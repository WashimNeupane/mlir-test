affine.for %i = 0 to %M {
  affine.for %j = 0 to %N {
    affine.for %k = 0 to %K {
      %a = affine.load %A[%i, %k] : memref<8192x8192xf64>
      %b = affine.load %B[%k, %j] : memref<8192x8192xf64>
      %c = affine.load %C[%i, %j] : memref<8192x8192xf64>
      %q = mulf %a, %b : f64
      %co = addf %c, %q : f64
      affine.store %co, %C[%i, %j] : memref<8192x8192xf64>
    }
  }
} with #unroll

