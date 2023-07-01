// display: flex;
// width: 1280px;
// padding: 20px 10px;
// justify-content: center;
// align-items: center;
// gap: 79px;

import { Flex, Link, Text } from "@chakra-ui/react";

export const Header: React.FC = () => {
    return (
      <Flex w="100%" padding="20px 10px" justifyContent="center" alignItems="center" gap="80px">
        <Link href="#">About</Link>
        <Link href="#">Docs</Link>
      </Flex>
    );
  };