import './globals.css'
import { Roboto } from 'next/font/google'

const inter = Roboto({ weight: "400", subsets: ['latin'] })

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
        <body className={inter.className}>{children}</body>
    </html>
  )
}
