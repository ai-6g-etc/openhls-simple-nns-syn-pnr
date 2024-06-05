module attributes {torch.debug_module_name = "Linear"} {
  memref.global "private" constant @__constant_11x11xf32 : memref<11x11xf32> = dense<"0xFC6B213E82B115BE00214A3DD8496ABCB76F2D3E97B776BEBF3436BEC1262BBE7AD3D43D200081BE08C21D3E51830E3ED560813EAC8A0CBEBC7C98BE9D3B973E2B538DBEF7FA983ECDD1D43D9956383DBB9A6DBE113D3B3CD29C2A3E242807BEA9BB05BEE8C7813EF9446F3DFA954F3B0488833EEBC314BEF08389BC095807BEF599B43D56614A3EF4780A3E8FABA2BD600769BEA75328BEF4F30CBEC09C8C3ED472143E3A3A5F3E0084153DE85462BD20CF7F3EC1B5DA3B601C58BEF95834BE0E86703E8F68FD3DA98C91BE7817B9BDA176D4BD0D3C823DB00592BE14A9853E8FC698BE4BF9AC3D39E1963D292E48BEF0C23B3D2D823DBE161BD5BD879927BE210B60BE913FA33D8481763EF84A7B3EC5D53D3E0081883E05BD803EAF90383E264E933E3345113D76712A3ED0BE32BE7850A3BC5012323E582327BE43D8BFBDD8DE2B3E480F8E3DC6E460BEA959473C0C5DBABC891F803ECA234A3BCA4287BDC726633ED724143EBF1993BE85D78D3DF396C2BCEEA77F3E7C3523BC1FB39ABD6D7199BCB7671ABE34C4BC3C9D4D58BC405D68BD73105ABE41B8613EF01300BE17306EBECA0E3DBE81C0F23D58E1DCBDFCD9663E136401BEE039913E3EE93B3EE611113E5ACE5EBE2860C43D0C6F63BDC978963E6AF9873EB526233E44497B3E964FAEBD">
  memref.global "private" constant @__constant_11xf32 : memref<11xf32> = dense<[0.251600713, 0.176484793, 0.164553955, 0.187063128, -0.117918655, -0.0012137217, 0.23328644, 0.059574835, -0.229450032, -0.0504425205, 0.0103477966]>
  func.func @forward(%arg0: memref<1x11xf32>) -> memref<f32> {
    %c0 = arith.constant 0 : index
    %c11 = arith.constant 11 : index
    %c1 = arith.constant 1 : index
    %cst = arith.constant 0.000000e+00 : f32
    %0 = memref.get_global @__constant_11xf32 : memref<11xf32>
    %1 = memref.get_global @__constant_11x11xf32 : memref<11x11xf32>
    %2 = memref.alloca() : memref<11x11xf32>
    scf.parallel (%arg1, %arg2) = (%c0, %c0) to (%c11, %c11) step (%c1, %c1) {
      %8 = memref.load %1[%arg1, %arg2] : memref<11x11xf32>
      memref.store %8, %2[%arg2, %arg1] : memref<11x11xf32>
      scf.yield
    }
    %3 = memref.alloca() : memref<1x11xf32>
    scf.parallel (%arg1, %arg2) = (%c0, %c0) to (%c1, %c11) step (%c1, %c1) {
      memref.store %cst, %3[%arg1, %arg2] : memref<1x11xf32>
      scf.yield
    }
    %4 = memref.alloca() : memref<1x11xf32>
    memref.copy %3, %4 : memref<1x11xf32> to memref<1x11xf32>
    scf.parallel (%arg1, %arg2) = (%c0, %c0) to (%c1, %c11) step (%c1, %c1) {
      scf.for %arg3 = %c0 to %c11 step %c1 {
        %8 = memref.load %arg0[%arg1, %arg3] : memref<1x11xf32>
        %9 = memref.load %2[%arg3, %arg2] : memref<11x11xf32>
        %10 = memref.load %4[%arg1, %arg2] : memref<1x11xf32>
        %11 = arith.mulf %8, %9 : f32
        %12 = arith.addf %10, %11 : f32
        memref.store %12, %4[%arg1, %arg2] : memref<1x11xf32>
      }
      scf.yield
    }
    %5 = memref.alloca() : memref<1x11xf32>
    scf.parallel (%arg1, %arg2) = (%c0, %c0) to (%c1, %c11) step (%c1, %c1) {
      %8 = memref.load %4[%c0, %arg2] : memref<1x11xf32>
      %9 = memref.load %0[%arg2] : memref<11xf32>
      %10 = arith.addf %8, %9 : f32
      memref.store %10, %5[%arg1, %arg2] : memref<1x11xf32>
      scf.yield
    }
    %6 = memref.alloca() : memref<f32>
    memref.store %cst, %6[] : memref<f32>
    %7 = memref.alloc() {alignment = 128 : i64} : memref<f32>
    memref.copy %6, %7 : memref<f32> to memref<f32>
    scf.for %arg1 = %c0 to %c1 step %c1 {
      scf.for %arg2 = %c0 to %c11 step %c1 {
        %8 = memref.load %5[%arg1, %arg2] : memref<1x11xf32>
        %9 = memref.load %7[] : memref<f32>
        %10 = arith.addf %8, %9 : f32
        memref.store %10, %7[] : memref<f32>
      }
    }
    return %7 : memref<f32>
  }
}
