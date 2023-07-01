'use client'

import { useState } from 'react';
import { Box, Button, ChakraProvider, Container, Flex, Heading, Image, Input, InputGroup, Stack, Text } from '@chakra-ui/react';
import { Header } from './components/header';

const Home: React.FC = () => {
  const [initialIpAddress, setinitialIpAddress] = useState('255.255.255.255')
  const [ipAddress, setIpAddress] = useState(initialIpAddress);

  return (
    <ChakraProvider>
    <Header></Header>
    <Box w={'100%'} h={'100vh'} position={'relative'} className="main">
      <Box id="main" display="flex" flexDirection="column" alignItems="center" gap={30}>
        <Flex id="top" direction="row" px={100} gap={150}
              justifyContent="space-between" alignItems="center">
          <Flex
            id="own you ip address"
            w={500} h={200} py={20} direction="column"
            justifyContent="center" alignItems="flex-start"
            gap={0} flexShrink={0} fontSize={50}
          >
            <Text color='#363131'>Own your</Text>
            <Text color='#FFAC2F' fontWeight={800}>NFT IP Address</Text>
          </Flex>
          <Image src="/mock_card.png"/>
        </Flex>
        <Flex flexDirection="column">
          <Text fontSize={32}>You can claim any free IP address!</Text>
          <Text fontSize={32}>Your current IP: <Text as="span" fontFamily="monospace" color="#FFAC2F">{initialIpAddress}</Text></Text>

          <InputGroup gap={30}>
            <Input
                placeholder='desired IP address...' 
                value={ipAddress}
                textAlign="center"
                />
              <Button
                loadingText='Loading'
                colorScheme='blue'
                spinnerPlacement='start'
              >
                Claim it!
              </Button>
          </InputGroup>
        </Flex>
      </Box>
    </Box>
    </ChakraProvider>
  );
};

export default Home;
