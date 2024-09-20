import React, { useState } from "react";
import { useNavigate } from "react-router-dom";
import { Input, Button, VStack, Text, useToast } from "@chakra-ui/react";

function Search() {
  const [address, setAddress] = useState("");
  const navigate = useNavigate();
  const toast = useToast();

  const handleSearch = () => {
    if (address.trim() === "") {
      toast({
        title: "Error",
        description: "Please enter a valid NFT address",
        status: "error",
        duration: 3000,
        isClosable: true,
      });
      return;
    }
    navigate(`/mint/${address}`);
  };

  return (
    <VStack color="purple" spacing={4} width="100%" maxWidth="500px">
      <Text fontSize="xl" fontWeight="bold">
        Enter NFT Contract Address
      </Text>
      <Input
        placeholder="0x..."
        value={address}
        onChange={(e) => setAddress(e.target.value)}
        border="1px"
        borderColor="gray.600"
        _placeholder={{ color: "gray.500" }}
      />
      <Button colorScheme="green" onClick={handleSearch}>
        Search
      </Button>
    </VStack>
  );
}

export default Search;
