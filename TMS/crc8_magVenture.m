% crc8_magVenture
% Written by Doby Rahnev and Justin Riddle
function CRC8_hex = crc8_magVenture( hexStr )

numBytes = length(hexStr) /2;
numBits = numBytes * 8;

% BigEndian (flip byte order)
hexStr_bigEndian = '';
for byteIdx = 1:numBytes
    flipByteIdx = ((numBytes - byteIdx) * 2) + 1;
    hexStr_bigEndian = [hexStr_bigEndian hexStr(flipByteIdx:flipByteIdx+1)];
end
% Convert from Hex to Binary
encode = de2bi(hex2dec(hexStr_bigEndian),numBits);

% CRC8 Calculator
% x^8 + x^5 + x^4 + 1
checkSumGen = comm.CRCGenerator([1 0 0 1 1 0 0 0 1]);
inputAndCRC8 = step(checkSumGen,encode');
CRC8_bi = inputAndCRC8(numBits+1:end);
CRC8_de = bi2de(CRC8_bi');

% Return value as a hex string
CRC8_hex = dec2hex(CRC8_de);

end