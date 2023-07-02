import { Text } from "@chakra-ui/layout"

interface AddressProps {
    hash: string
  }

export const Address: React.FC<AddressProps> = ({hash}) => {
    return <Text as="span" fontFamily="monospace">{hash}</Text>
}
