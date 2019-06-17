#!/bin/bash
#
# Copyright IBM Corp All Rights Reserved
#
# SPDX-License-Identifier: Apache-2.0
#
# Exit on first error
set -e

# don't rewrite paths for Windows Git Bash users
export MSYS_NO_PATHCONV=1

starttime=$(date +%s)


# Now launch the CLI container in order to install, instantiate chaincode
# and prime the ledger with our 10 cars

 
#docker-compose -f ./docker-peer12.yaml up -d

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" cli peer channel create -o orderer.example.com:7050 -c mychannel   -f ./channel-artifacts/mychannel.tx
sleep 4

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" cli peer chaincode install -n vote -p github.com/hyperledger/fabric/aberic/chaincode/go/chaincode_example02 -v 1.0
sleep 4

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" cli peer channel join -b mychannel.block
sleep 4


docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" cli peer chaincode instantiate -o orderer.example.com:7050 -C mychannel -n vote -c '{"Args":[""]}' -P "OR ('Org1MSP.member','Org2MSP.member')"  -v 1.0
sleep 4
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" cli peer chaincode invoke -o orderer.example.com:7050 -C mychannel -n vote -c '{"function":"getUserVote","Args":[""]}'
sleep 4


docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer1.org1.example.com:8003" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/ca.crt" cli peer channel join -b mychannel.block
sleep 4
 
 
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer1.org1.example.com:8003" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/ca.crt" cli peer chaincode install -n vote -p github.com/hyperledger/fabric/aberic/chaincode/go/chaincode_example02 -v 1.0
sleep 4
 

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer1.org1.example.com:8003" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer1.org1.example.com/tls/ca.crt" cli peer chaincode invoke -o orderer.example.com:7050 -C mychannel -n vote -c '{"function":"getUserVote","Args":[""]}'
sleep 4

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer2.org1.example.com:8006" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer2.org1.example.com/tls/ca.crt" cli peer channel join -b mychannel.block
sleep 4
 
 
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer2.org1.example.com:8006" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer2.org1.example.com/tls/ca.crt" cli peer chaincode install -n vote -p github.com/hyperledger/fabric/aberic/chaincode/go/chaincode_example02 -v 1.0
sleep 4
 

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer2.org1.example.com:8006" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer2.org1.example.com/tls/ca.crt" cli peer chaincode invoke -o orderer.example.com:7050 -C mychannel -n vote -c '{"function":"getUserVote","Args":[""]}'
sleep 4

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer3.org1.example.com:8009" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer3.org1.example.com/tls/ca.crt" cli peer channel join -b mychannel.block
sleep 4
 
 
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer3.org1.example.com:8009" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer3.org1.example.com/tls/ca.crt" cli peer chaincode install -n vote -p github.com/hyperledger/fabric/aberic/chaincode/go/chaincode_example02 -v 1.0
sleep 4
 

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer3.org1.example.com:8009" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer3.org1.example.com/tls/ca.crt" cli peer chaincode invoke -o orderer.example.com:7050 -C mychannel -n vote -c '{"function":"getUserVote","Args":[""]}'
sleep 4

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer4.org1.example.com:8012" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer4.org1.example.com/tls/ca.crt" cli peer channel join -b mychannel.block
sleep 4
 
 
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer4.org1.example.com:8012" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer4.org1.example.com/tls/ca.crt" cli peer chaincode install -n vote -p github.com/hyperledger/fabric/aberic/chaincode/go/chaincode_example02 -v 1.0
sleep 4
 

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer4.org1.example.com:8012" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer4.org1.example.com/tls/ca.crt" cli peer chaincode invoke -o orderer.example.com:7050 -C mychannel -n vote -c '{"function":"getUserVote","Args":[""]}'
sleep 4

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer5.org1.example.com:8015" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer5.org1.example.com/tls/ca.crt" cli peer channel join -b mychannel.block
sleep 4
 
 
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer5.org1.example.com:8015" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer5.org1.example.com/tls/ca.crt" cli peer chaincode install -n vote -p github.com/hyperledger/fabric/aberic/chaincode/go/chaincode_example02 -v 1.0
sleep 4
 

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer5.org1.example.com:8015" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer5.org1.example.com/tls/ca.crt" cli peer chaincode invoke -o orderer.example.com:7050 -C mychannel -n vote -c '{"function":"getUserVote","Args":[""]}'
sleep  4

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer6.org1.example.com:8018" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer6.org1.example.com/tls/ca.crt" cli peer channel join -b mychannel.block
sleep 4
 
 
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer6.org1.example.com:8018" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer6.org1.example.com/tls/ca.crt" cli peer chaincode install -n vote -p github.com/hyperledger/fabric/aberic/chaincode/go/chaincode_example02 -v 1.0
sleep 4
 

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer6.org1.example.com:8018" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer6.org1.example.com/tls/ca.crt" cli peer chaincode invoke -o orderer.example.com:7050 -C mychannel -n vote -c '{"function":"getUserVote","Args":[""]}'
sleep 4

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer7.org1.example.com:8021" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer7.org1.example.com/tls/ca.crt" cli peer channel join -b mychannel.block
sleep 4
 
 
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer7.org1.example.com:8021" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer7.org1.example.com/tls/ca.crt" cli peer chaincode install -n vote -p github.com/hyperledger/fabric/aberic/chaincode/go/chaincode_example02 -v 1.0
sleep 4
 

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer7.org1.example.com:8021" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer7.org1.example.com/tls/ca.crt" cli peer chaincode invoke -o orderer.example.com:7050 -C mychannel -n vote -c '{"function":"getUserVote","Args":[""]}'
sleep 4

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer8.org1.example.com:8024" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer8.org1.example.com/tls/ca.crt" cli peer channel join -b mychannel.block
sleep 4
 
 
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer8.org1.example.com:8024" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer8.org1.example.com/tls/ca.crt" cli peer chaincode install -n vote -p github.com/hyperledger/fabric/aberic/chaincode/go/chaincode_example02 -v 1.0
sleep 4
 

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer8.org1.example.com:8024" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer8.org1.example.com/tls/ca.crt" cli peer chaincode invoke -o orderer.example.com:7050 -C mychannel -n vote -c '{"function":"getUserVote","Args":[""]}'
sleep 4

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer9.org1.example.com:8027" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer9.org1.example.com/tls/ca.crt" cli peer channel join -b mychannel.block
sleep 4
 
 
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer9.org1.example.com:8027" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer9.org1.example.com/tls/ca.crt" cli peer chaincode install -n vote -p github.com/hyperledger/fabric/aberic/chaincode/go/chaincode_example02 -v 1.0
sleep 4
 

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer9.org1.example.com:8027" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer9.org1.example.com/tls/ca.crt" cli peer chaincode invoke -o orderer.example.com:7050 -C mychannel -n vote -c '{"function":"getUserVote","Args":[""]}'
sleep 4

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer10.org1.example.com:8030" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer10.org1.example.com/tls/ca.crt" cli peer channel join -b mychannel.block
sleep 4
 
 
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer10.org1.example.com:8030" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer10.org1.example.com/tls/ca.crt" cli peer chaincode install -n vote -p github.com/hyperledger/fabric/aberic/chaincode/go/chaincode_example02 -v 1.0
sleep 4
 

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer10.org1.example.com:8030" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer10.org1.example.com/tls/ca.crt" cli peer chaincode invoke -o orderer.example.com:7050 -C mychannel -n vote -c '{"function":"getUserVote","Args":[""]}'
sleep 4

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer11.org1.example.com:8033" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer11.org1.example.com/tls/ca.crt" cli peer channel join -b mychannel.block
sleep 4
 
 
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer11.org1.example.com:8033" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer11.org1.example.com/tls/ca.crt" cli peer chaincode install -n vote -p github.com/hyperledger/fabric/aberic/chaincode/go/chaincode_example02 -v 1.0
sleep 4
 

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer11.org1.example.com:8033" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer11.org1.example.com/tls/ca.crt" cli peer chaincode invoke -o orderer.example.com:7050 -C mychannel -n vote -c '{"function":"getUserVote","Args":[""]}'
sleep 4

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer12.org1.example.com:8036" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer12.org1.example.com/tls/ca.crt" cli peer channel join -b mychannel.block
sleep 4
 
 
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer12.org1.example.com:8036" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer12.org1.example.com/tls/ca.crt" cli peer chaincode install -n vote -p github.com/hyperledger/fabric/aberic/chaincode/go/chaincode_example02 -v 1.0
sleep 4
 

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer12.org1.example.com:8036" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer12.org1.example.com/tls/ca.crt" cli peer chaincode invoke -o orderer.example.com:7050 -C mychannel -n vote -c '{"function":"getUserVote","Args":[""]}'
sleep 4

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer13.org1.example.com:8039" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer13.org1.example.com/tls/ca.crt" cli peer channel join -b mychannel.block
sleep 4
 
 
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer13.org1.example.com:8039" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer13.org1.example.com/tls/ca.crt" cli peer chaincode install -n vote -p github.com/hyperledger/fabric/aberic/chaincode/go/chaincode_example02 -v 1.0
sleep 4
 

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer13.org1.example.com:8039" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer13.org1.example.com/tls/ca.crt" cli peer chaincode invoke -o orderer.example.com:7050 -C mychannel -n vote -c '{"function":"getUserVote","Args":[""]}'
sleep 4

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer14.org1.example.com:8042" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer14.org1.example.com/tls/ca.crt" cli peer channel join -b mychannel.block
sleep 4
 
 
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer14.org1.example.com:8042" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer14.org1.example.com/tls/ca.crt" cli peer chaincode install -n vote -p github.com/hyperledger/fabric/aberic/chaincode/go/chaincode_example02 -v 1.0
sleep 4
 

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer14.org1.example.com:8042" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer14.org1.example.com/tls/ca.crt" cli peer chaincode invoke -o orderer.example.com:7050 -C mychannel -n vote -c '{"function":"getUserVote","Args":[""]}'
sleep 4

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer15.org1.example.com:8045" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer15.org1.example.com/tls/ca.crt" cli peer channel join -b mychannel.block
sleep 4
 
 
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer15.org1.example.com:8045" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer15.org1.example.com/tls/ca.crt" cli peer chaincode install -n vote -p github.com/hyperledger/fabric/aberic/chaincode/go/chaincode_example02 -v 1.0
sleep 4
 

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer15.org1.example.com:8045" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer15.org1.example.com/tls/ca.crt" cli peer chaincode invoke -o orderer.example.com:7050 -C mychannel -n vote -c '{"function":"getUserVote","Args":[""]}'
sleep 10

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer16.org1.example.com:8048" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer16.org1.example.com/tls/ca.crt" cli peer channel join -b mychannel.block
sleep 4
 
 
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer16.org1.example.com:8048" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer16.org1.example.com/tls/ca.crt" cli peer chaincode install -n vote -p github.com/hyperledger/fabric/aberic/chaincode/go/chaincode_example02 -v 1.0
sleep 4
 

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer16.org1.example.com:8048" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer16.org1.example.com/tls/ca.crt" cli peer chaincode invoke -o orderer.example.com:7050 -C mychannel -n vote -c '{"function":"getUserVote","Args":[""]}'
sleep 10

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer17.org1.example.com:8051" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer17.org1.example.com/tls/ca.crt" cli peer channel join -b mychannel.block
sleep 4
 
 
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer17.org1.example.com:8051" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer17.org1.example.com/tls/ca.crt" cli peer chaincode install -n vote -p github.com/hyperledger/fabric/aberic/chaincode/go/chaincode_example02 -v 1.0
sleep 4
 

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer17.org1.example.com:8051" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer17.org1.example.com/tls/ca.crt" cli peer chaincode invoke -o orderer.example.com:7050 -C mychannel -n vote -c '{"function":"getUserVote","Args":[""]}'
sleep 10

 

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer19.org1.example.com:8057" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer19.org1.example.com/tls/ca.crt" cli peer channel join -b mychannel.block
sleep 4
 
 
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer19.org1.example.com:8057" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer19.org1.example.com/tls/ca.crt" cli peer chaincode install -n vote -p github.com/hyperledger/fabric/aberic/chaincode/go/chaincode_example02 -v 1.0
sleep 4
 

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer19.org1.example.com:8057" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer19.org1.example.com/tls/ca.crt" cli peer chaincode invoke -o orderer.example.com:7050 -C mychannel -n vote -c '{"function":"getUserVote","Args":[""]}'
sleep 10

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer20.org1.example.com:8060" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer20.org1.example.com/tls/ca.crt" cli peer channel join -b mychannel.block
sleep 4
 
 
docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer20.org1.example.com:8060" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer20.org1.example.com/tls/ca.crt" cli peer chaincode install -n vote -p github.com/hyperledger/fabric/aberic/chaincode/go/chaincode_example02 -v 1.0
sleep 4
 

docker exec -e "CORE_PEER_LOCALMSPID=Org1MSP" -e "CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp" -e  "CORE_PEER_ADDRESS=peer20.org1.example.com:8060" -e "CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer20.org1.example.com/tls/ca.crt" cli peer chaincode invoke -o orderer.example.com:7050 -C mychannel -n vote -c '{"function":"getUserVote","Args":[""]}'
sleep 4












printf "\nTotal setup execution time : $(($(date +%s) - starttime)) secs ...\n\n\n"
printf "Start by installing required packages run 'npm install'\n"
printf "Then run 'node enrollAdmin.js', then 'node registerUser'\n\n"
printf "The 'node invoke.js' will fail until it has been updated with valid arguments\n"
printf "The 'node query.js' may be run at anytime once the user has been registered\n\n"
