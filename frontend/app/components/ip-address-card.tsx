import { Image } from "@chakra-ui/image"

interface IPAddressCardProps {
    ip: string
  }

export const IPAddressCard: React.FC<IPAddressCardProps> = ({ip}) => {
    return <Image w={200} src="/rare.png"/>
}