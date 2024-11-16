
include "../node_modules/circomlib/circuits/escalarmulany.circom";
include "../node_modules/circomlib/circuits/pedersen.circom";
include "merkleTree.circom";


template EddsaMulAny() {
    signal input privkey;
    signal input basePoint[2];
    signal output pubkey[2];

    signal privkeyList[256];
    component n2b = Num2Bits(256);
    n2b.in <== privkey;
    for(var i=0; i<256; i++){
        privkeyList[i] <== n2b.out[i];
    }

    component mulAny = EscalarMulAny(256);
    for (var i=0; i<256; i++) {
        mulAny.e[i] <== privkeyList[i];
    }
    mulAny.p[0] <== basePoint[0];
    mulAny.p[1] <== basePoint[1];


    pubkey[0] <== mulAny.out[0];
    pubkey[1] <== mulAny.out[1];

}

template EddsaMulFix() {
    signal input privkey;
    // signal input basePoint[2];
    signal output pubkey[2];

    signal privkeyList[256];
    component n2b = Num2Bits(256);
    n2b.in <== privkey;
    for(var i=0; i<256; i++){
        privkeyList[i] <== n2b.out[i];
    }

    var BASE8[2] = [
        5299619240641551281634865583518297030282874472190772894086521144482721001553,
        16950150798460657717958625567821834550301663161624707787222815936182638968203
    ];

    component mulFix = EscalarMulFix(256, BASE8);
    for (var i=0; i<256; i++) {
        mulFix.e[i] <== privkeyList[i];
    }

    pubkey[0] <== mulFix.out[0];
    pubkey[1] <== mulFix.out[1];

}

template Pedersen_Curve_Point(){
    signal input in[2]; 
    signal output out;

    component hasher = Pedersen(496);
    component n2b0 = Num2Bits(256);  // for curve point
    component n2b1 = Num2Bits(256);  // for curve point
    n2b0.in <== in[0];
    n2b1.in <== in[1];
    for (var i = 0; i < 248; i++) {
        hasher.in[i] <== n2b0.out[i];
        hasher.in[i + 248] <== n2b1.out[i];
    }
    out <== hasher.out[0];
}







// Verifies that commitment that corresponds to given secret and nullifier is included in the merkle tree of deposits
template Withdraw(nums, levels) {
    // public input
    signal input rootList[nums];  // public
    signal input E[2]; // pubic, multi-sig supervisor address base point G

    signal input recipient; // public, not taking part in any computations
    signal input relayer;  // public, not taking part in any computations
    signal input fee;      // public,nnot taking part in any computations
    signal input refund;   // public, not taking part in any computations

    // private input
    signal input root;
    signal input rootPowerIndex;  // 2**i, i is the rootList index that equat to root
    
    signal input secret;
    signal input pathElements[levels];
    signal input pathIndices[levels];

    // output
    signal output kH_Hash;  // withdraw proof 
    signal output kE[2];  // can be recove to kG, and link to depositor


    // check root
    component n2b = Num2Bits(nums);
    n2b.in <== rootPowerIndex;
    signal n2bSum[nums];
    n2bSum[0] <== n2b.out[0];
    for(var i=1; i<nums; i++){
        n2bSum[i] <== n2bSum[i-1] + n2b.out[i];
    }
    n2bSum[nums-1] === 1;  // ensure only match one
    signal rootSum[nums];
    rootSum[0] <== rootList[0] * n2b.out[0];
    for(var i=1; i<nums; i++){
        rootSum[i] <== rootList[i] * n2b.out[i] + rootSum[i-1];
    }
    rootSum[nums-1] === root;


    // kG_Hash leaf
    component kG = EddsaMulFix();
    component kG_Hash = Pedersen_Curve_Point();
    kG.privkey <== secret;
    kG_Hash.in[0] <== kG.pubkey[0];
    kG_Hash.in[1] <== kG.pubkey[1];


    // withdraw proof, kH_Hash
    signal H[2];  // unkown privkey point H
    H[0] <== 6735765341259699143139827009349789187539604393960868243100492584654517940357;
    H[1] <== 1445652303469103813662583567528138751416053152308969014699137575678043505465;
    component kH = EddsaMulAny();
    component hasher02 = Pedersen_Curve_Point();
    kH.privkey <== secret;
    kH.basePoint[0] <== H[0];
    kH.basePoint[1] <== H[1];
    hasher02.in[0] <== kH.pubkey[0];
    hasher02.in[1] <== kH.pubkey[1];
    kH_Hash <== hasher02.out;


    // deposit trace
    component _kE = EddsaMulAny();
    _kE.privkey <== secret;
    _kE.basePoint[0] <== E[0];
    _kE.basePoint[1] <== E[1];
    kE[0] <== _kE.pubkey[0];
    kE[1] <== _kE.pubkey[1];

    // check root
    component tree = MerkleTreeChecker(levels);
    tree.leaf <== kG_Hash.out;
    tree.root <== root;
    for (var i = 0; i < levels; i++) {
        tree.pathElements[i] <== pathElements[i];
        tree.pathIndices[i] <== pathIndices[i];
    }


    // Add hidden signals to make sure that tampering with recipient or fee will invalidate the snark proof
    // Most likely it is not required, but it's better to stay on the safe side and it only takes 2 constraints
    // Squares are used to prevent optimizer from removing those constraints
    signal recipientSquare;
    signal feeSquare;
    signal relayerSquare;
    signal refundSquare;
    recipientSquare <== recipient * recipient;
    feeSquare <== fee * fee;
    relayerSquare <== relayer * relayer;
    refundSquare <== refund * refund;

}

component main {public [rootList, E, recipient, relayer, fee, refund]} = Withdraw(32, 10);
