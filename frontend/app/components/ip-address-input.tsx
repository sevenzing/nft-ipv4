'use client'

import React, { useState, ChangeEvent, useEffect } from "react";
import { Input, Button, FormErrorMessage, FormControl, FormHelperText, Box, Text, Flex } from "@chakra-ui/react";

interface IPAddressInputProps {
ipAddress: string;
setIPAddress: React.Dispatch<React.SetStateAction<string>>;
isLoading: boolean,
setIsLoading: React.Dispatch<React.SetStateAction<boolean>>,
  handleMintRequest: () => void;
  children: React.ReactNode
}

const IPAddressInput: React.FC<IPAddressInputProps> = ({
  ipAddress,
  setIPAddress,
  isLoading,
  children,
}) => {
  const [ipAddressInput, setIPAddressInput] = useState('');
  const [ipAddressInitial, setIPAddressInitial] = useState('');
  const [isInvalid, setIsInvalid] = useState(false);


  const handleChange = (e: ChangeEvent<HTMLInputElement>) => {
    setIPAddressInput(e.target.value);
    if (validateIPAddress(e.target.value)) {
        setIsInvalid(false);
    } else { 
        setIsInvalid(true);
    }
  };

  const updateIpAddress = () => {
    if (!isInvalid && ipAddressInput && ipAddressInput !== ipAddress) {
      setIPAddress(ipAddressInput)
    }
  }

  const validateIPAddress = (ip: string): boolean => {
    const pattern = /^([0-9]{1,3}\.){3}[0-9]{1,3}$/;
    return pattern.test(ip);
  };

  useEffect(() => {
    fetch('https://api.ipify.org/?format=json')
      .then((response) => response.json())
      .then((data) => {
        setIPAddressInput(data.ip)
        setIPAddressInitial(data.ip)
        setIPAddress(data.ip)
      })
      .catch((error) => console.error('Error fetching IP address:', error));
  }, []);

  return (
    <Flex mt={50} flexDirection="column" color='black'>
        <Text fontSize={32}>You can claim any free IP address!</Text>
        <Text fontSize={24}>For example, claim your IP: <Text as="span" fontFamily="monospace" color="orange.300">{ipAddressInitial}</Text></Text>
        <FormControl isInvalid={isInvalid} mt={10} display="flex" justifyContent="center">
            <Input
                placeholder="Enter IP Address"
                value={ipAddressInput}
                onChange={handleChange}
                isInvalid={isInvalid}
                errorBorderColor="crimson"
                borderColor='gray.400'
                fontFamily="monospace"
                onBlurCapture={updateIpAddress}
                maxW={300}
            />
            <Button
                ml={3}
                w={100}
                loadingText='Loading'
                colorScheme='yellow'
                spinnerPlacement='start'
                variant="solid"
                isDisabled={isInvalid}
                isLoading={isLoading}
                onClick={() => console.log("asdasd")}
                >{ipAddress === ipAddressInput ? 'Claim it!' : 'Check'}
            </Button>
        </FormControl>
        {children}
    </Flex>
  );
};

export default IPAddressInput;
