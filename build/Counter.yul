object "CounterDeploy" {
  code {
    function usr$_start () {
      mstore(64, memoryguard(128))
      if lt(codesize(), datasize("CounterDeploy")) {revert(0, 0)}
      if callvalue() {mstore(0, 3046674083)
                      revert(28, 4)}
      usr$invokable_invoke$t_init_169160()
      let size := datasize("Counter")
      codecopy(0, dataoffset("Counter"), datasize("Counter"))
      return(0, size)
    }
    function usr$init_ () { }
    function usr$invokable_invoke$t_init_169160 () {
      usr$init_()
      leave
    }
    usr$_start()
  }
  object "Counter" {
    code {
      function usr$__strlit_0 () -> _result {
        let p
        p := mload(64)
        mstore(p, 9)
        mstore(add(p, 32), 53115649371004818019938606350605950488420297339660994745436179602424213798912)
        mstore(64, add(p, 64))
        _result := p
        leave
      }
      function usr$ABIDecode_decode$ABIDecoderLuint256_readerJ$CalldataWordReader (ptr, currentHeadOffset) -> _result {
        let _v0
        let _v1
        _v1 := usr$WordReader_advance$ABIDecoderLty_readerJ$uint256_CalldataWordReader(ptr, currentHeadOffset)
        let _v2
        _v2 := usr$WordReader_read$ABIDecoderLty_readerJ$uint256_CalldataWordReader(_v1)
        let _v3
        _v3 := usr$Typedef_abs$uint256(_v2)
        _v0 := _v3
        _result := _v0
        leave
      }
      function usr$ABIEncode_encodeInto$uint256 (x, basePtr, offset, tail) -> _result {
        let repx
        let _v4
        _v4 := usr$Typedef_rep$uint256(x)
        repx := _v4
        let _v5
        _v5 := usr$Add_add$word(basePtr, offset)
        usr$mstore(_v5, repx)
        _result := tail
        leave
      }
      function usr$ABIEncode_encodeInto$unit (basePtr, offset, tail) -> _result {
        _result := tail
        leave
      }
      function usr$Add_add$uint256 (x, y) -> _result {
        let _v6
        _v6 := usr$Typedef_rep$uint256(x)
        let _v7
        _v7 := usr$Typedef_rep$uint256(y)
        let _v8
        _v8 := usr$Add_add$word(_v6, _v7)
        let _v9
        _v9 := usr$Typedef_abs$uint256(_v8)
        _result := _v9
        leave
      }
      function usr$Add_add$word (l, r) -> _result {
        let _v10
        _v10 := usr$addWord(l, r)
        _result := _v10
        leave
      }
      function usr$Assign_assign$a$storageLuint256J_uint256 (l, r) {
        usr$CanStore_store$storageLuint256J(l, r)
      }
      function usr$CanStore_load$storageLuint256J (l) -> _result {
        let _v11
        _v11 := usr$Typedef_rep$storageLtJ$uint256(l)
        let _v12
        _v12 := usr$StorageType_load$uint256(_v11)
        _result := _v12
        leave
      }
      function usr$CanStore_store$storageLuint256J (l, r) {
        let _v13
        _v13 := usr$Typedef_rep$storageLtJ$uint256(l)
        usr$StorageType_store$uint256(_v13, r)
      }
      function usr$Eq_eq$word (x, y) -> _v14 {
        let _v15
        _v15 := usr$eqWord(x, y)
        _v14 := _v15
        leave
      }
      function usr$ExecMethod_exec$FallbackLpayability_unit_unit_fnJ$NonPayable_t_fallback_default_implementation90961 () {
        usr$MethodLevelCallvalueCheck_checkCallvalue$NonPayable()
        usr$invokable_invoke$t_fallback_default_implementation90961()
        stop()
      }
      function usr$ExecMethod_exec$MethodLname_NonPayable_args_rets_fnJ$DispatchNameTy_Counter_decrement_unit_unit_t_decrement152530 () {
        usr$MethodLevelCallvalueCheck_checkCallvalue$NonPayable()
        usr$do_exec$unit_unit_t_decrement152530()
      }
      function usr$ExecMethod_exec$MethodLname_NonPayable_args_rets_fnJ$DispatchNameTy_Counter_increment_unit_unit_t_increment148387 () {
        usr$MethodLevelCallvalueCheck_checkCallvalue$NonPayable()
        usr$do_exec$unit_unit_t_increment148387()
      }
      function usr$ExecMethod_exec$MethodLname_NonPayable_args_rets_fnJ$DispatchNameTy_Counter_number_unit_uint256_t_number144358 () {
        usr$MethodLevelCallvalueCheck_checkCallvalue$NonPayable()
        usr$do_exec$unit_uint256_t_number144358()
      }
      function usr$ExecMethod_exec$MethodLname_NonPayable_args_rets_fnJ$DispatchNameTy_Counter_setNumber_uint256_unit_t_setNumber140441 () {
        usr$MethodLevelCallvalueCheck_checkCallvalue$NonPayable()
        usr$do_exec$uint256_unit_t_setNumber140441()
      }
      function usr$HasWordReader_getWordReader$calldataLbytesJ (x) -> _result {
        let _v16
        _v16 := usr$Typedef_rep$calldataLtJ$bytes(x)
        _result := _v16
        leave
      }
      function usr$MemoryPointer_ptr$memoryLbytesJ (v) -> _result {
        let _v17
        _v17 := usr$Typedef_rep$memoryLtJ$bytes(v)
        let _v18
        _v18 := usr$Add_add$word(_v17, 32)
        _result := _v18
        leave
      }
      function usr$MemorySize_len$memoryLbytesJ (v) -> _result {
        let _v19
        _v19 := usr$Typedef_rep$memoryLtJ$bytes(v)
        let _v20
        _v20 := usr$mload(_v19)
        _result := _v20
        leave
      }
      function usr$MethodLevelCallvalueCheck_checkCallvalue$NonPayable () {
        let _v21
        let _v22
        let _v23
        _v21 := false
        _v22 := 3046674083
        let _v24
        _v24 := usr$callvalue()
        let _v25
        _v25 := usr$Eq_eq$word(_v24, 0)
        usr$require(_v25, false, 3046674083, 911)
      }
      function usr$Ord_gt$uint256 (x, y) -> _v26 {
        let _v27
        _v27 := usr$Typedef_rep$uint256(x)
        let _v28
        _v28 := usr$Typedef_rep$uint256(y)
        let _v29
        _v29 := usr$Ord_gt$word(_v27, _v28)
        _v26 := _v29
        leave
      }
      function usr$Ord_gt$word (x, y) -> _v30 {
        let _v31
        _v31 := usr$gtWord(x, y)
        _v30 := _v31
        leave
      }
      function usr$RVA_acc$MemberAccessProxyLContractStorageLcxtJ_fieldSelector_loadType_offsetTypeJ$CounterCxt_Counter_number_sel_uint256_unit () -> _result {
        let offset
        offset := 0
        let _v32
        _v32 := 0
        let _v33
        let _v34
        _v34 := usr$CanStore_load$storageLuint256J(0)
        _v33 := _v34
        _result := _v33
        leave
      }
      function usr$RunContract_exec$ContractLmethods_fbJ$pairLMethodLDispatchNameTy_Counter_number_NonPayable_unit_uint256_t_number144358J_pairLMethodLDispatchNameTy_Counter_setNumber_NonPayable_uint256_unit_t_setNumber140441J_pairLMethodLDispatchNameTy_Counter_increment_NonPayable_unit_unit_t_increment148387J_MethodLDispatchNameTy_Counter_decrement_NonPayable_unit_unit_t_decrement152530JJJJ_FallbackLNonPayable_unit_unit_t_fallback_default_implementation90961J () {
        mstore(64, memoryguard(128))
        let _v35
        let _v36
        _v36 := usr$calldatasize()
        let _v37
        _v37 := usr$ge$word(_v36, 4)
        _v35 := _v37
        switch _v35
          case false {}
          case true {usr$RunDispatch_go$pairLn_mJ$MethodLDispatchNameTy_Counter_number_NonPayable_unit_uint256_t_number144358J_pairLMethodLDispatchNameTy_Counter_setNumber_NonPayable_uint256_unit_t_setNumber140441J_pairLMethodLDispatchNameTy_Counter_increment_NonPayable_unit_unit_t_increment148387J_MethodLDispatchNameTy_Counter_decrement_NonPayable_unit_unit_t_decrement152530JJJ()}
        usr$ExecMethod_exec$FallbackLpayability_unit_unit_fnJ$NonPayable_t_fallback_default_implementation90961()
      }
      function usr$RunDispatch_go$MethodLname_payability_args_rets_fnJ$DispatchNameTy_Counter_decrement_NonPayable_unit_unit_t_decrement152530 () {
        let _v38
        let _v39
        _v39 := usr$selector_matches$MethodLDispatchNameTy_Counter_decrement_NonPayable_unit_unit_t_decrement152530J()
        _v38 := _v39
        switch _v38
          case false {leave}
          case true {usr$ExecMethod_exec$MethodLname_NonPayable_args_rets_fnJ$DispatchNameTy_Counter_decrement_unit_unit_t_decrement152530()}
      }
      function usr$RunDispatch_go$pairLn_mJ$MethodLDispatchNameTy_Counter_increment_NonPayable_unit_unit_t_increment148387J_MethodLDispatchNameTy_Counter_decrement_NonPayable_unit_unit_t_decrement152530J () {
        let _v40
        let _v41
        _v41 := usr$selector_matches$MethodLDispatchNameTy_Counter_increment_NonPayable_unit_unit_t_increment148387J()
        _v40 := _v41
        switch _v40
          case false {usr$RunDispatch_go$MethodLname_payability_args_rets_fnJ$DispatchNameTy_Counter_decrement_NonPayable_unit_unit_t_decrement152530()}
          case true {usr$ExecMethod_exec$MethodLname_NonPayable_args_rets_fnJ$DispatchNameTy_Counter_increment_unit_unit_t_increment148387()}
      }
      function usr$RunDispatch_go$pairLn_mJ$MethodLDispatchNameTy_Counter_number_NonPayable_unit_uint256_t_number144358J_pairLMethodLDispatchNameTy_Counter_setNumber_NonPayable_uint256_unit_t_setNumber140441J_pairLMethodLDispatchNameTy_Counter_increment_NonPayable_unit_unit_t_increment148387J_MethodLDispatchNameTy_Counter_decrement_NonPayable_unit_unit_t_decrement152530JJJ () {
        let _v42
        let _v43
        _v43 := usr$selector_matches$MethodLDispatchNameTy_Counter_number_NonPayable_unit_uint256_t_number144358J()
        _v42 := _v43
        switch _v42
          case false {usr$RunDispatch_go$pairLn_mJ$MethodLDispatchNameTy_Counter_setNumber_NonPayable_uint256_unit_t_setNumber140441J_pairLMethodLDispatchNameTy_Counter_increment_NonPayable_unit_unit_t_increment148387J_MethodLDispatchNameTy_Counter_decrement_NonPayable_unit_unit_t_decrement152530JJ()}
          case true {usr$ExecMethod_exec$MethodLname_NonPayable_args_rets_fnJ$DispatchNameTy_Counter_number_unit_uint256_t_number144358()}
      }
      function usr$RunDispatch_go$pairLn_mJ$MethodLDispatchNameTy_Counter_setNumber_NonPayable_uint256_unit_t_setNumber140441J_pairLMethodLDispatchNameTy_Counter_increment_NonPayable_unit_unit_t_increment148387J_MethodLDispatchNameTy_Counter_decrement_NonPayable_unit_unit_t_decrement152530JJ () {
        let _v44
        let _v45
        _v45 := usr$selector_matches$MethodLDispatchNameTy_Counter_setNumber_NonPayable_uint256_unit_t_setNumber140441J()
        _v44 := _v45
        switch _v44
          case false {usr$RunDispatch_go$pairLn_mJ$MethodLDispatchNameTy_Counter_increment_NonPayable_unit_unit_t_increment148387J_MethodLDispatchNameTy_Counter_decrement_NonPayable_unit_unit_t_decrement152530J()}
          case true {usr$ExecMethod_exec$MethodLname_NonPayable_args_rets_fnJ$DispatchNameTy_Counter_setNumber_uint256_unit_t_setNumber140441()}
      }
      function usr$StorageType_load$uint256 (ptr) -> _result {
        let syntaxValue5
        let _v46
        _v46 := usr$StorageType_load$word(ptr)
        syntaxValue5 := _v46
        _result := syntaxValue5
        leave
      }
      function usr$StorageType_load$word (ptr) -> _result {
        let _v47
        _v47 := usr$sload(ptr)
        _result := _v47
        leave
      }
      function usr$StorageType_store$uint256 (ptr, value) {
        let syntaxValue6
        let _v48
        _v48 := usr$Typedef_rep$uint256(value)
        syntaxValue6 := _v48
        usr$StorageType_store$word(ptr, syntaxValue6)
      }
      function usr$StorageType_store$word (ptr, value) {
        usr$sstore(ptr, value)
      }
      function usr$Sub_sub$uint256 (x, y) -> _result {
        let _v49
        _v49 := usr$Typedef_rep$uint256(x)
        let _v50
        _v50 := usr$Typedef_rep$uint256(y)
        let _v51
        _v51 := usr$Sub_sub$word(_v49, _v50)
        let _v52
        _v52 := usr$Typedef_abs$uint256(_v51)
        _result := _v52
        leave
      }
      function usr$Sub_sub$word (l, r) -> _result {
        let _v53
        _v53 := usr$subWord(l, r)
        _result := _v53
        leave
      }
      function usr$Typedef_abs$uint256 (w) -> _result {
        _result := w
        leave
      }
      function usr$Typedef_rep$calldataLtJ$bytes (x) -> _result {
        _result := x
        leave
      }
      function usr$Typedef_rep$memoryLtJ$bytes (x) -> _result {
        _result := x
        leave
      }
      function usr$Typedef_rep$memoryLtJ$string (x) -> _result {
        _result := x
        leave
      }
      function usr$Typedef_rep$storageLtJ$uint256 (x) -> _result {
        _result := x
        leave
      }
      function usr$Typedef_rep$uint256 (x) -> _result {
        _result := x
        leave
      }
      function usr$WordReader_advance$ABIDecoderLty_readerJ$uint256_CalldataWordReader (decoder, offset) -> _result {
        let _v54
        _v54 := usr$WordReader_advance$CalldataWordReader(decoder, offset)
        _result := _v54
        leave
      }
      function usr$WordReader_advance$CalldataWordReader (reader, offset) -> _result {
        let _v55
        _v55 := usr$Add_add$word(reader, offset)
        _result := _v55
        leave
      }
      function usr$WordReader_read$ABIDecoderLty_readerJ$uint256_CalldataWordReader (decoder) -> _result {
        let _v56
        _v56 := usr$WordReader_read$CalldataWordReader(decoder)
        _result := _v56
        leave
      }
      function usr$WordReader_read$CalldataWordReader (reader) -> _result {
        let _v57
        _v57 := usr$calldataload(reader)
        _result := _v57
        leave
      }
      function usr$abi_decode$calldataLbytesJ_uint256_CalldataWordReader_uint256 (decodable) -> _result {
        let _v58
        let _v59
        _v59 := usr$HasWordReader_getWordReader$calldataLbytesJ(decodable)
        _v58 := _v59
        let _v60
        _v60 := usr$ABIDecode_decode$ABIDecoderLuint256_readerJ$CalldataWordReader(_v58, 0)
        _result := _v60
        leave
      }
      function usr$abi_encode$uint256 (val) -> _result {
        let ret
        let _v61
        _v61 := usr$get_free_memory()
        ret := _v61
        let start
        let _v62
        _v62 := usr$Add_add$word(ret, 32)
        start := _v62
        let tail
        let _v63
        _v63 := usr$Add_add$word(start, 32)
        let _v64
        _v64 := usr$ABIEncode_encodeInto$uint256(val, start, 0, _v63)
        tail := _v64
        let _v65
        _v65 := usr$Sub_sub$word(tail, start)
        usr$mstore(ret, _v65)
        usr$set_free_memory(tail)
        _result := ret
        leave
      }
      function usr$abi_encode$unit () -> _result {
        let ret
        let _v66
        _v66 := usr$get_free_memory()
        ret := _v66
        let start
        let _v67
        _v67 := usr$Add_add$word(ret, 32)
        start := _v67
        let tail
        let _v68
        _v68 := usr$Add_add$word(start, 0)
        let _v69
        _v69 := usr$ABIEncode_encodeInto$unit(start, 0, _v68)
        tail := _v69
        let _v70
        _v70 := usr$Sub_sub$word(tail, start)
        usr$mstore(ret, _v70)
        usr$set_free_memory(tail)
        _result := ret
        leave
      }
      function usr$add (a, b) -> _result {
        let res
        res := add(a, b)
        _result := res
        leave
      }
      function usr$addWord (l, r) -> _result {
        let _v71
        _v71 := usr$add(l, r)
        _result := _v71
        leave
      }
      function usr$calldataload (a) -> _result {
        let res
        res := calldataload(a)
        _result := res
        leave
      }
      function usr$calldatasize () -> _result {
        let res
        res := calldatasize()
        _result := res
        leave
      }
      function usr$callvalue () -> _result {
        let res
        res := callvalue()
        _result := res
        leave
      }
      function usr$decrement () {
        let _v72
        _v72 := usr$RVA_acc$MemberAccessProxyLContractStorageLcxtJ_fieldSelector_loadType_offsetTypeJ$CounterCxt_Counter_number_sel_uint256_unit()
        let _v73
        _v73 := usr$Ord_gt$uint256(_v72, 0)
        let _v74
        let _v75
        let _v76
        _v74, _v75, _v76 := usr$Str_fromString$Error$ct0()
        usr$require(_v73, _v74, _v75, _v76)
        let _v77
        _v77 := 0
        let _v78
        _v78 := usr$CanStore_load$storageLuint256J(0)
        let _v79
        _v79 := usr$Sub_sub$uint256(_v78, 1)
        usr$Assign_assign$a$storageLuint256J_uint256(0, _v79)
      }
      function usr$do_exec$uint256_unit_t_setNumber140441 () {
        let _v80
        _v80 := usr$calldatasize()
        let _v81
        _v81 := usr$ge$word(_v80, 36)
        usr$require(_v81, false, 140739926, 911)
        let _v82
        _v82 := 4
        let _v83
        let _v84
        _v84 := usr$abi_decode$calldataLbytesJ_uint256_CalldataWordReader_uint256(4)
        _v83 := _v84
        usr$invokable_invoke$t_setNumber140441(_v83)
        let _v85
        let _v86
        _v86 := usr$abi_encode$unit()
        _v85 := _v86
        let _v87
        _v87 := usr$MemoryPointer_ptr$memoryLbytesJ(_v85)
        let _v88
        _v88 := usr$MemorySize_len$memoryLbytesJ(_v85)
        usr$return_(_v87, _v88)
      }
      function usr$do_exec$unit_uint256_t_number144358 () {
        let _v89
        _v89 := usr$calldatasize()
        let _v90
        _v90 := usr$ge$word(_v89, 4)
        usr$require(_v90, false, 140739926, 911)
        let _v91
        _v91 := 4
        let _v92
        let _v93
        _v93 := usr$invokable_invoke$t_number144358()
        _v92 := _v93
        let _v94
        let _v95
        _v95 := usr$abi_encode$uint256(_v92)
        _v94 := _v95
        let _v96
        _v96 := usr$MemoryPointer_ptr$memoryLbytesJ(_v94)
        let _v97
        _v97 := usr$MemorySize_len$memoryLbytesJ(_v94)
        usr$return_(_v96, _v97)
      }
      function usr$do_exec$unit_unit_t_decrement152530 () {
        let _v98
        _v98 := usr$calldatasize()
        let _v99
        _v99 := usr$ge$word(_v98, 4)
        usr$require(_v99, false, 140739926, 911)
        let _v100
        _v100 := 4
        usr$invokable_invoke$t_decrement152530()
        let _v101
        let _v102
        _v102 := usr$abi_encode$unit()
        _v101 := _v102
        let _v103
        _v103 := usr$MemoryPointer_ptr$memoryLbytesJ(_v101)
        let _v104
        _v104 := usr$MemorySize_len$memoryLbytesJ(_v101)
        usr$return_(_v103, _v104)
      }
      function usr$do_exec$unit_unit_t_increment148387 () {
        let _v105
        _v105 := usr$calldatasize()
        let _v106
        _v106 := usr$ge$word(_v105, 4)
        usr$require(_v106, false, 140739926, 911)
        let _v107
        _v107 := 4
        usr$invokable_invoke$t_increment148387()
        let _v108
        let _v109
        _v109 := usr$abi_encode$unit()
        _v108 := _v109
        let _v110
        _v110 := usr$MemoryPointer_ptr$memoryLbytesJ(_v108)
        let _v111
        _v111 := usr$MemorySize_len$memoryLbytesJ(_v108)
        usr$return_(_v110, _v111)
      }
      function usr$eq (a, b) -> _result {
        let res
        res := eq(a, b)
        _result := res
        leave
      }
      function usr$eqWord (x, y) -> _v112 {
        let _v113
        _v113 := usr$eq(x, y)
        let _v114
        _v114 := usr$tobool(_v113)
        _v112 := _v114
        leave
      }
      function usr$fallback_default_implementation () {
        let _v115
        let _v116
        let _v117
        _v115 := false
        _v116 := 1227140848
        usr$revertWithError(false, 1227140848, 911)
      }
      function usr$ge$word (x, y) -> _v118 {
        let _v119
        _v119 := usr$le$word(y, x)
        _v118 := _v119
        leave
      }
      function usr$get_free_memory () -> _result {
        let _v120
        _v120 := usr$mload(64)
        _result := _v120
        leave
      }
      function usr$gtWord (x, y) -> _v121 {
        let _v122
        _v122 := usr$gt_(x, y)
        let _v123
        _v123 := usr$tobool(_v122)
        _v121 := _v123
        leave
      }
      function usr$gt_ (a, b) -> _result {
        let res
        res := gt(a, b)
        _result := res
        leave
      }
      function usr$increment () {
        let _v124
        _v124 := 0
        let _v125
        _v125 := usr$CanStore_load$storageLuint256J(0)
        let _v126
        _v126 := usr$Add_add$uint256(_v125, 1)
        usr$Assign_assign$a$storageLuint256J_uint256(0, _v126)
      }
      function usr$invokable_invoke$t_decrement152530 () {
        usr$decrement()
        leave
      }
      function usr$invokable_invoke$t_fallback_default_implementation90961 () {
        usr$fallback_default_implementation()
        leave
      }
      function usr$invokable_invoke$t_increment148387 () {
        usr$increment()
        leave
      }
      function usr$invokable_invoke$t_number144358 () -> _result {
        let _v127
        _v127 := usr$number()
        _result := _v127
        leave
      }
      function usr$invokable_invoke$t_setNumber140441 (arg140443) {
        let _v128
        _v128 := arg140443
        usr$setNumber(_v128)
        leave
      }
      function usr$le$word (x, y) -> _v129 {
        let _v130
        _v130 := usr$Ord_gt$word(x, y)
        let _v131
        _v131 := usr$not(_v130)
        _v129 := _v131
        leave
      }
      function usr$main () -> _v132 {
        usr$RunContract_exec$ContractLmethods_fbJ$pairLMethodLDispatchNameTy_Counter_number_NonPayable_unit_uint256_t_number144358J_pairLMethodLDispatchNameTy_Counter_setNumber_NonPayable_uint256_unit_t_setNumber140441J_pairLMethodLDispatchNameTy_Counter_increment_NonPayable_unit_unit_t_increment148387J_MethodLDispatchNameTy_Counter_decrement_NonPayable_unit_unit_t_decrement152530JJJJ_FallbackLNonPayable_unit_unit_t_fallback_default_implementation90961J()
      }
      function usr$mload (a) -> _result {
        let res
        res := mload(a)
        _result := res
        leave
      }
      function usr$mstore (a, b) { mstore(a, b) }
      function usr$not (_v133) -> _v134 {
        switch _v133
          case false {_v134 := true
                      leave}
          case true {_v134 := false
                     leave}
      }
      function usr$number () -> _result {
        let _v135
        _v135 := usr$RVA_acc$MemberAccessProxyLContractStorageLcxtJ_fieldSelector_loadType_offsetTypeJ$CounterCxt_Counter_number_sel_uint256_unit()
        _result := _v135
        leave
      }
      function usr$require (_v136, _v137, _v138, _v139) {
        let _v140
        let _v141
        _v141 := usr$not(_v136)
        _v140 := _v141
        switch _v140
          case false {}
          case true {usr$revertWithError(_v137, _v138, _v139)}
      }
      function usr$return_ (a, b) { return(a, b) }
      function usr$revertWithError (_v142, _v143, _v144) {
        switch _v142
          case false {usr$mstore(0, _v143)
                      usr$revert_(28, 4)}
          case true {switch _v143
                       case false {usr$revert_(0, 0)}
                       case true {let msg_
                                  let _v145
                                  _v145 := usr$Typedef_rep$memoryLtJ$string(_v144)
                                  msg_ := _v145
                                  let _v146
                                  _v146 := usr$Add_add$word(msg_, 32)
                                  let _v147
                                  _v147 := usr$mload(msg_)
                                  usr$revert_(_v146, _v147)}}
      }
      function usr$revert_ (a, b) { revert(a, b) }
      function usr$selector_matches$MethodLDispatchNameTy_Counter_decrement_NonPayable_unit_unit_t_decrement152530J () -> _v148 {
        let candidate
        candidate := 732876471
        let selector
        let _v149
        _v149 := usr$calldataload(0)
        let _v150
        _v150 := usr$shr(224, _v149)
        selector := _v150
        let _v151
        _v151 := usr$Eq_eq$word(selector, 732876471)
        _v148 := _v151
        leave
      }
      function usr$selector_matches$MethodLDispatchNameTy_Counter_increment_NonPayable_unit_unit_t_increment148387J () -> _v152 {
        let candidate
        candidate := 3500007562
        let selector
        let _v153
        _v153 := usr$calldataload(0)
        let _v154
        _v154 := usr$shr(224, _v153)
        selector := _v154
        let _v155
        _v155 := usr$Eq_eq$word(selector, 3500007562)
        _v152 := _v155
        leave
      }
      function usr$selector_matches$MethodLDispatchNameTy_Counter_number_NonPayable_unit_uint256_t_number144358J () -> _v156 {
        let candidate
        candidate := 2206332298
        let selector
        let _v157
        _v157 := usr$calldataload(0)
        let _v158
        _v158 := usr$shr(224, _v157)
        selector := _v158
        let _v159
        _v159 := usr$Eq_eq$word(selector, 2206332298)
        _v156 := _v159
        leave
      }
      function usr$selector_matches$MethodLDispatchNameTy_Counter_setNumber_NonPayable_uint256_unit_t_setNumber140441J () -> _v160 {
        let candidate
        candidate := 1068876235
        let selector
        let _v161
        _v161 := usr$calldataload(0)
        let _v162
        _v162 := usr$shr(224, _v161)
        selector := _v162
        let _v163
        _v163 := usr$Eq_eq$word(selector, 1068876235)
        _v160 := _v163
        leave
      }
      function usr$setNumber (newNumber) {
        usr$Assign_assign$a$storageLuint256J_uint256(0, newNumber)
      }
      function usr$set_free_memory (loc) { usr$mstore(64, loc) }
      function usr$shr (a, b) -> _result {
        let res
        res := shr(a, b)
        _result := res
        leave
      }
      function usr$sload (a) -> _result {
        let res
        res := sload(a)
        _result := res
        leave
      }
      function usr$sstore (a, b) { sstore(a, b) }
      function usr$sub (a, b) -> _result {
        let res
        res := sub(a, b)
        _result := res
        leave
      }
      function usr$subWord (l, r) -> _result {
        let _v164
        _v164 := usr$sub(l, r)
        _result := _v164
        leave
      }
      function usr$tobool (x) -> _v165 {
        switch x
          case 0 {_v165 := false
                  leave}
        default {_v165 := true
                 leave}
      }
      function usr$Str_fromString$Error$ct0 () -> _v166, _v167, _v168 {
        let _v169
        _v169 := usr$__strlit_0()
        _v166 := true
        _v167 := true
        _v168 := _v169
        leave
      }
      let _mainresult := usr$main()
      mstore(0, _mainresult)
      return(0, 32)
    }
  }
}