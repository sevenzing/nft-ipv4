'use client'

import { useEffect, useState } from 'react';
import { Box, Button, Flex, FormControl, FormErrorMessage, Image, InputGroup, Text } from '@chakra-ui/react';
import { Header } from './components/header';
import IPAddressInput from './components/ip-address-input';
import { IPAddressCard } from './components/ip-address-card';
import { Address } from './components/address';


type Props = {
  ip: string
}

const Home: React.FC = () => {
  const [ipAddress, setIPAddress] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [alreadyMintedByAddress, setAlreadyMintedByAddress] = useState("0x123123132");
  const [error, setError] = useState('')

  useEffect(() => {
    if (ipAddress) {
      setIsLoading(true)
      setTimeout(() => {setIsLoading(false)}, 1000)
    }
  }, [ipAddress])


  return (
      <Box w="100%" h="100vh" 
          bgGradient="radial(63.61% 97.39% at 21.37% 35.40%, #FFF4E8 1.96%, #F4E3EB 22.87%, #D1EDF9 93.67%)"
      >
        <Header></Header>
          <Flex flexDirection="column" alignItems="center" gap={30}>
            <Flex id="top" direction="row" px={[0, 100]} gap={[0, 150]}
                  justifyContent="space-between" alignItems="center">
              <Flex
                id="own you ip address"
                w={500} h={200} py={20} direction="column"
                justifyContent="center" alignItems="flex-start"
                gap={0} flexShrink={0} fontSize={[50]}
              >
                <Text>Own your</Text>
                <Text bgClip='text' bgGradient='linear(to-l, purple.300, orange.300)' fontWeight={800}>NFT IPv4 Address</Text>
              </Flex>
              <IPAddressCard ip={ipAddress}/>
            </Flex>
              <IPAddressInput 
                ipAddress={ipAddress} setIPAddress={setIPAddress} 
                isLoading={isLoading} setIsLoading={setIsLoading} 
                handleMintRequest={() => {}}
              >
                {error && <Text color="crimson">{error}</Text>}
              </IPAddressInput>
          </Flex>
      </Box>
  );
};

export default Home;

