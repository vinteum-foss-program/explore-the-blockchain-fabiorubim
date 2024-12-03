# How many new outputs were created by block 123,456?
# 24
#!/bin/bash

# Specify the block height
block_height=123456

# Fetch the block hash for the given height
block_hash=$(/Users/frubim/vinteum/bitcoin/src/bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser=user_076 -rpcpassword=E5LRtMvMTjkR getblockhash $block_height)

# Fetch the block data using the block hash
block_data=$(/Users/frubim/vinteum/bitcoin/src/bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser=user_076 -rpcpassword=E5LRtMvMTjkR getblock $block_hash)

# Extract the transaction IDs from the block
txids=$(echo $block_data | jq -r '.tx[]')

# Initialize the output counter
total_outputs=0

# Loop through each transaction ID to count outputs
for txid in $txids; do
  # Fetch the raw transaction data
  raw_tx=$(/Users/frubim/vinteum/bitcoin/src/bitcoin-cli -rpcconnect=84.247.182.145 -rpcuser=user_076 -rpcpassword=E5LRtMvMTjkR getrawtransaction $txid true)
  
  # Count the number of outputs in the transaction
  outputs=$(echo $raw_tx | jq '.vout | length')
  
  # Add to the total output count
  total_outputs=$((total_outputs + outputs))
done

# Print the total number of outputs
echo $total_outputs