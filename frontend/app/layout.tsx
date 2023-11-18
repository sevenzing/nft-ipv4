import './globals.css'
import { Inter } from 'next/font/google'
import { Providers } from './providers'

const inter = Inter({ weight: "400", subsets: ['latin'] })

export const metadata = {
  title: 'Own an NFT IP address',
  description: 'Web3 NFT project related to Internet Protocol v4',
}

export default function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  return (
    <html lang="en">
        <body className={inter.className}>
          <Providers>
            {children}
          </Providers>
        </body>
    </html>
  )
}
