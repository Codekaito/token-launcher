import { TokenCreate, TokenCreate__factory, Token__factory } from "../typechain-types"
import { ethers } from "hardhat"
import { SignerWithAddress } from "@nomicfoundation/hardhat-ethers/signers"
import { expect } from "chai"
import { parseUnits } from "ethers"

describe('TokenFactory', () => {
    let tokenFactory: TokenCreate
    let owner: SignerWithAddress
    const initialSupply = parseUnits('1000000', 18)

    beforeEach(async() => {
        [owner] = await ethers.getSigners()
        tokenFactory = await new TokenCreate__factory(owner).deploy()
    })

    it('should create a new token', async() => {
        const tx = await tokenFactory.connect(owner).createToken(
            'Test Token', 
            'TST', 
            18, 
            initialSupply
        )
        const receipt = await tx.wait()
        
        // Get the last event from transaction logs
        const lastLog = receipt?.logs[receipt.logs.length - 1]
        expect(lastLog).to.not.be.undefined

        // Parse the event to get the deployed token address
        const tokenAddress = tokenFactory.interface.parseLog({
            topics: lastLog!.topics,
            data: lastLog!.data
        })!.args[0]

        // Connect to the newly created token contract
        const token = Token__factory.connect(tokenAddress, ethers.provider)

        // Verify token initial supply was minted to owner
        const balanceOwner = await token.balanceOf(owner.address)
        expect(balanceOwner).to.equal(initialSupply)
    })
})