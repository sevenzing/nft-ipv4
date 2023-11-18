'use client'

import { ChakraProvider } from '@chakra-ui/react'
import { polygon } from 'wagmi/chains'
import { WagmiConfig, configureChains, createConfig } from 'wagmi'
import { jsonRpcProvider } from 'wagmi/providers/jsonRpc'
import { publicProvider } from 'wagmi/providers/public'
import { InjectedConnector } from 'wagmi/connectors/injected'



export function Providers({ 
    children 
  }: { 
  children: React.ReactNode 
  }) {

    const { chains, publicClient } = configureChains(
      [polygon],
      [
        jsonRpcProvider({
          rpc: (chain) => ({
            http: `https://${chain.id}.example.com`,
          }),
        }),
        publicProvider(),
      ],
    )
    const config = createConfig({
      autoConnect: true,
      connectors: [new InjectedConnector({ chains })],
      publicClient,
    })

  return (
    <WagmiConfig config={config}>
      <ChakraProvider>
        {children}
      </ChakraProvider>
    </WagmiConfig>
  )
}