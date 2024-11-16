#!/bin/bash

mkdir -p ptau
mkdir -p build

wget -c https://storage.googleapis.com/zkevm/ptau/powersOfTau28_hez_final_16.ptau -O ptau/powersOfTau28_hez_final_16.ptau
circom src/deposit.circom --r1cs --wasm --json -o build/

# setup 
snarkjs groth16 setup build/deposit.r1cs ptau/powersOfTau28_hez_final_16.ptau build/circuit_0000.zkey
snarkjs zkey contribute build/circuit_0000.zkey build/circuit_0001.zkey --name="1st Contributor Name" -v -e="1st random entropy"
snarkjs zkey contribute build/circuit_0001.zkey build/circuit_0002.zkey --name="Second contribution Name" -v -e="2nd random entropy"

snarkjs zkey export bellman build/circuit_0002.zkey build/challenge_phase2_0003
snarkjs zkey bellman contribute bn128 build/challenge_phase2_0003 build/response_phase2_0003 -e="some random text"
snarkjs zkey import bellman build/circuit_0002.zkey build/response_phase2_0003 build/circuit_0003.zkey -n="Third contribution name"
# snarkjs zkey verify build/deposit.r1cs ptau/powersOfTau28_hez_final_16.ptau build/circuit_0003.zkey

snarkjs zkey beacon build/circuit_0003.zkey build/deposit.zkey 0102030405060708090a0b0c0d0e0f101112131415161718191a1b1c1d1e1f 10 -n="Final Beacon phase2"
# snarkjs zkey verify build/deposit.r1cs ptau/powersOfTau28_hez_final_16.ptau build/deposit.zkey

snarkjs zkey export verificationkey build/deposit.zkey build/verification_key_deposit.json
snarkjs zkey export solidityverifier build/deposit.zkey build/verifier_deposit.sol

cp build/verifier_deposit.sol ./verifier/

cp build/deposit_js/deposit.wasm ./build_for_ui/
cp build/deposit.zkey ./build_for_ui/
