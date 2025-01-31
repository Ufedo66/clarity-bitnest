import { Clarinet, Tx, Chain, Account, types } from 'https://deno.land/x/clarinet@v0.14.0/index.ts';
import { assertEquals } from 'https://deno.land/std@0.90.0/testing/asserts.ts';

Clarinet.test({
  name: "Ensure property registration works",
  async fn(chain: Chain, accounts: Map<string, Account>) {
    const wallet_1 = accounts.get("wallet_1")!;
    
    let block = chain.mineBlock([
      Tx.contractCall(
        "property-registry",
        "register-property",
        [
          types.ascii("123 Test St"),
          types.uint(1000)
        ],
        wallet_1.address
      )
    ]);
    assertEquals(block.receipts.length, 1);
    assertEquals(block.height, 2);
  }
});

Clarinet.test({
  name: "Ensure property status update works",
  async fn(chain: Chain, accounts: Map<string, Account>) {
    const wallet_1 = accounts.get("wallet_1")!;
    
    // First register a property
    let block = chain.mineBlock([
      Tx.contractCall(
        "property-registry",
        "register-property",
        [
          types.ascii("123 Test St"),
          types.uint(1000)
        ],
        wallet_1.address
      )
    ]);
    
    // Then update its status
    block = chain.mineBlock([
      Tx.contractCall(
        "property-registry",
        "update-property-status",
        [
          types.uint(1),
          types.bool(false)
        ],
        wallet_1.address
      )
    ]);
    assertEquals(block.receipts.length, 1);
    assertEquals(block.receipts[0].result, '(ok true)');
  }
});
