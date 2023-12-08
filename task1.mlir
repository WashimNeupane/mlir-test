#map0 = affine_map<(d0, d1, d2) -> (d0, d2, d1)>

func @matmul(%A: tensor<?x?xf32>, %B: tensor<?x?xf32>, %C: tensor<?x?xf32>) {
  %D = linalg.generic
    ins(%A, %B : tensor<?x?xf32>, tensor<?x?xf32>)
    outs(%C : tensor<?x?xf32>)
    indexing_maps = [#map0, #map0, #map0]
    iterator_types = ["parallel", "parallel", "reduction"] {
      ^bb(%a: index, %b: index, %c: index):
        %a_val = tensor.extract %A[%a, %c] : tensor<?x?xf32> to f32
        %b_val = tensor.extract %B[%c, %b] : tensor<?x?xf32> to f32
        %c_val = linalg.load %C[%a, %b] : tensor<?x?xf32>
        %mul = arith.mulf %a_val, %b_val : f32
        %add = arith.addf %c_val, %mul : f32
        linalg.store %add, %C[%a, %b] : tensor<?x?xf32>
        linalg.yield
    }
  return %D : tensor<?x?xf32>
}

