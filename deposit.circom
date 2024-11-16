
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

    // BASE8 = 8*BASE
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
template Deposit() {
    signal input secret;
    signal input S[2]; // pubic, multi-sig supervisor address base unkown privatekey point H

    signal output kG_Hash;  // hash for kG, store as leaf on chain
    signal output kS[2];  // // can be recove to kH, and link to withdrawer

    component kG = EddsaMulFix();
    component hasher = Pedersen_Curve_Point();
    kG.privkey <== secret;
    hasher.in[0] <== kG.pubkey[0];
    hasher.in[1] <== kG.pubkey[1];
    kG_Hash <== hasher.out;


    // withdraw trace
    component _kS = EddsaMulAny();
    _kS.privkey <== secret;
    _kS.basePoint[0] <== S[0];
    _kS.basePoint[1] <== S[1];
    kS[0] <== _kS.pubkey[0];
    kS[1] <== _kS.pubkey[1];

}

component main {public [S]}= Deposit();

