import * as Index from '../ts/index';

describe("buf2str", () => {
  it('convert 0xff, 0xff', () => {
    const target = new Uint8Array([0xff, 0xff]);
    expect(Index.buf2str(target)).toEqual('ffff');
  });
  it('convert 0xff, 0xff', () => {
    const target = new Uint8Array([0x01, 0x02]);
    expect(Index.buf2str(target)).toEqual('0102');
  });
  it('convert empty', () => {
    const target = new Uint8Array([]);
    expect(Index.buf2str(target)).toEqual('');
  });
});

describe("generate_salt_and_encrypted_pass", () => {
 it('generate pubkey', (done: DoneFn) => {
   Index.generate_salt_and_encrypted_pass("password").then(pair => {
     console.log(pair.password);
     expect(pair.password.length).toEqual(64);
     expect(pair.pubkey.alg).toEqual('RSA-OAEP-256');
     done();
   });
 });
});
