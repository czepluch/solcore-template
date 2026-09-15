object "ProbeDeploy" {
  code {
    function usr$ABIDecode_decode$ABIDecoderLuint256_readerJ$MemoryWordReader (ptr, currentHeadOffset) -> _result {
      let _v0
      let _v1
      _v1 := usr$WordReader_advance$ABIDecoderLty_readerJ$uint256_MemoryWordReader(ptr, currentHeadOffset)
      let _v2
      _v2 := usr$WordReader_read$ABIDecoderLty_readerJ$uint256_MemoryWordReader(_v1)
      let _v3
      _v3 := usr$Typedef_abs$uint256(_v2)
      _v0 := _v3
      _result := _v0
      leave
    }
    function usr$Add_add$uint256 (x, y) -> _result {
      let _v4
      _v4 := usr$Typedef_rep$uint256(x)
      let _v5
      _v5 := usr$Typedef_rep$uint256(y)
      let _v6
      _v6 := usr$Add_add$word(_v4, _v5)
      let _v7
      _v7 := usr$Typedef_abs$uint256(_v6)
      _result := _v7
      leave
    }
    function usr$Add_add$word (l, r) -> _result {
      let _v8
      _v8 := usr$addWord(l, r)
      _result := _v8
      leave
    }
    function usr$Assign_assign$a$storageLuint256J_uint256 (l, r) {
      usr$CanStore_store$storageLuint256J(l, r)
    }
    function usr$CanStore_store$storageLuint256J (l, r) {
      let _v9
      _v9 := usr$Typedef_rep$storageLtJ$uint256(l)
      usr$StorageType_store$uint256(_v9, r)
    }
    function usr$HasWordReader_getWordReader$memoryLbytesJ (x) -> _result {
      let _v10
      _v10 := usr$Typedef_rep$memoryLtJ$bytes(x)
      _result := _v10
      leave
    }
    function usr$StorageType_store$uint256 (ptr, value) {
      let syntaxValue6
      let _v11
      _v11 := usr$Typedef_rep$uint256(value)
      syntaxValue6 := _v11
      usr$StorageType_store$word(ptr, syntaxValue6)
    }
    function usr$StorageType_store$word (ptr, value) {
      usr$sstore(ptr, value)
    }
    function usr$Typedef_abs$uint256 (w) -> _result {
      _result := w
      leave
    }
    function usr$Typedef_rep$memoryLtJ$bytes (x) -> _result {
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
    function usr$WordReader_advance$ABIDecoderLty_readerJ$uint256_MemoryWordReader (decoder, offset) -> _result {
      let _v12
      _v12 := usr$WordReader_advance$MemoryWordReader(decoder, offset)
      _result := _v12
      leave
    }
    function usr$WordReader_advance$MemoryWordReader (reader, offset) -> _result {
      let _v13
      _v13 := usr$Add_add$word(reader, offset)
      _result := _v13
      leave
    }
    function usr$WordReader_read$ABIDecoderLty_readerJ$uint256_MemoryWordReader (decoder) -> _result {
      let _v14
      _v14 := usr$WordReader_read$MemoryWordReader(decoder)
      _result := _v14
      leave
    }
    function usr$WordReader_read$MemoryWordReader (reader) -> _result {
      let _v15
      _v15 := usr$mload(reader)
      _result := _v15
      leave
    }
    function usr$_start () {
      mstore(64, memoryguard(128))
      if lt(codesize(), datasize("ProbeDeploy")) {revert(0, 0)}
      if callvalue() {mstore(0, 3046674083)
                      revert(28, 4)}
      let _v16
      let _v17
      _v17 := usr$copy_arguments_for_constructor()
      _v16 := _v17
      usr$invokable_invoke$t_init_173806(_v16)
      let size := datasize("Probe")
      codecopy(0, dataoffset("Probe"), datasize("Probe"))
      return(0, size)
    }
    function usr$abi_decode$memoryLbytesJ_uint256_MemoryWordReader_uint256 (decodable) -> _result {
      let _v18
      let _v19
      _v19 := usr$HasWordReader_getWordReader$memoryLbytesJ(decodable)
      _v18 := _v19
      let _v20
      _v20 := usr$ABIDecode_decode$ABIDecoderLuint256_readerJ$MemoryWordReader(_v18, 0)
      _result := _v20
      leave
    }
    function usr$add (a, b) -> _result {
      let res
      res := add(a, b)
      _result := res
      leave
    }
    function usr$addWord (l, r) -> _result {
      let _v21
      _v21 := usr$add(l, r)
      _result := _v21
      leave
    }
    function usr$copy_arguments_for_constructor () -> _result {
      let _v22
      let memoryDataOffset
      let programSize := datasize("ProbeDeploy")
      let argSize := sub(codesize(), programSize)
      memoryDataOffset := mload(64)
      mstore(64, add(memoryDataOffset, argSize))
      codecopy(memoryDataOffset, programSize, argSize)
      let _v23
      _v23 := memoryDataOffset
      let _v24
      _v24 := usr$abi_decode$memoryLbytesJ_uint256_MemoryWordReader_uint256(_v23)
      _v22 := _v24
      _result := _v22
      leave
    }
    function usr$init_ (x) {
      usr$Assign_assign$a$storageLuint256J_uint256(0, x)
      let _v25
      _v25 := usr$Add_add$uint256(x, 1)
      usr$Assign_assign$a$storageLuint256J_uint256(1, _v25)
    }
    function usr$invokable_invoke$t_init_173806 (arg173808) {
      let _v26
      _v26 := arg173808
      usr$init_(_v26)
      leave
    }
    function usr$mload (a) -> _result {
      let res
      res := mload(a)
      _result := res
      leave
    }
    function usr$sstore (a, b) { sstore(a, b) }
    usr$_start()
  }
  object "Probe" {
    code {
      function usr$__strlit_0 () -> _result {
        let p
        p := mload(64)
        mstore(p, 25)
        mstore(add(p, 32), 36387217198625767467451713530187510761242371787536895731847635974061570392064)
        mstore(64, add(p, 64))
        _result := p
        leave
      }
      function usr$ABIDecode_decode$ABIDecoderLuint256_readerJ$CalldataWordReader (ptr, currentHeadOffset) -> _result {
        let _v27
        let _v28
        _v28 := usr$WordReader_advance$ABIDecoderLty_readerJ$uint256_CalldataWordReader(ptr, currentHeadOffset)
        let _v29
        _v29 := usr$WordReader_read$ABIDecoderLty_readerJ$uint256_CalldataWordReader(_v28)
        let _v30
        _v30 := usr$Typedef_abs$uint256(_v29)
        _v27 := _v30
        _result := _v27
        leave
      }
      function usr$ABIEncode_encodeInto$uint256 (x, basePtr, offset, tail) -> _result {
        let repx
        let _v31
        _v31 := usr$Typedef_rep$uint256(x)
        repx := _v31
        let _v32
        _v32 := usr$Add_add$word(basePtr, offset)
        usr$mstore(_v32, repx)
        _result := tail
        leave
      }
      function usr$Add_add$word (l, r) -> _result {
        let _v33
        _v33 := usr$addWord(l, r)
        _result := _v33
        leave
      }
      function usr$CanStore_load$storageLuint256J (l) -> _result {
        let _v34
        _v34 := usr$Typedef_rep$storageLtJ$uint256(l)
        let _v35
        _v35 := usr$StorageType_load$uint256(_v34)
        _result := _v35
        leave
      }
      function usr$Eq_eq$word (x, y) -> _v36 {
        let _v37
        _v37 := usr$eqWord(x, y)
        _v36 := _v37
        leave
      }
      function usr$ExecMethod_exec$FallbackLpayability_unit_unit_fnJ$NonPayable_t_fallback_default_implementation91682 () {
        usr$MethodLevelCallvalueCheck_checkCallvalue$NonPayable()
        usr$invokable_invoke$t_fallback_default_implementation91682()
        stop()
      }
      function usr$ExecMethod_exec$MethodLname_NonPayable_args_rets_fnJ$DispatchNameTy_Probe_bareLit_uint256_uint256_t_bareLit156865 () {
        usr$MethodLevelCallvalueCheck_checkCallvalue$NonPayable()
        usr$do_exec$uint256_uint256_t_bareLit156865()
      }
      function usr$ExecMethod_exec$MethodLname_NonPayable_args_rets_fnJ$DispatchNameTy_Probe_demandPositive_uint256_uint256_t_demandPositive152947 () {
        usr$MethodLevelCallvalueCheck_checkCallvalue$NonPayable()
        usr$do_exec$uint256_uint256_t_demandPositive152947()
      }
      function usr$ExecMethod_exec$MethodLname_NonPayable_args_rets_fnJ$DispatchNameTy_Probe_getExtra_unit_uint256_t_getExtra145106 () {
        usr$MethodLevelCallvalueCheck_checkCallvalue$NonPayable()
        usr$do_exec$unit_uint256_t_getExtra145106()
      }
      function usr$ExecMethod_exec$MethodLname_NonPayable_args_rets_fnJ$DispatchNameTy_Probe_get_unit_uint256_t_get149048 () {
        usr$MethodLevelCallvalueCheck_checkCallvalue$NonPayable()
        usr$do_exec$unit_uint256_t_get149048()
      }
      function usr$HasWordReader_getWordReader$calldataLbytesJ (x) -> _result {
        let _v38
        _v38 := usr$Typedef_rep$calldataLtJ$bytes(x)
        _result := _v38
        leave
      }
      function usr$MemoryPointer_ptr$memoryLbytesJ (v) -> _result {
        let _v39
        _v39 := usr$Typedef_rep$memoryLtJ$bytes(v)
        let _v40
        _v40 := usr$Add_add$word(_v39, 32)
        _result := _v40
        leave
      }
      function usr$MemorySize_len$memoryLbytesJ (v) -> _result {
        let _v41
        _v41 := usr$Typedef_rep$memoryLtJ$bytes(v)
        let _v42
        _v42 := usr$mload(_v41)
        _result := _v42
        leave
      }
      function usr$MethodLevelCallvalueCheck_checkCallvalue$NonPayable () {
        let _v43
        let _v44
        let _v45
        _v43 := false
        _v44 := 3046674083
        let _v46
        _v46 := usr$callvalue()
        let _v47
        _v47 := usr$Eq_eq$word(_v46, 0)
        usr$require(_v47, false, 3046674083, 911)
      }
      function usr$Ord_gt$uint256 (x, y) -> _v48 {
        let _v49
        _v49 := usr$Typedef_rep$uint256(x)
        let _v50
        _v50 := usr$Typedef_rep$uint256(y)
        let _v51
        _v51 := usr$Ord_gt$word(_v49, _v50)
        _v48 := _v51
        leave
      }
      function usr$Ord_gt$word (x, y) -> _v52 {
        let _v53
        _v53 := usr$gtWord(x, y)
        _v52 := _v53
        leave
      }
      function usr$RVA_acc$MemberAccessProxyLContractStorageLcxtJ_fieldSelector_loadType_offsetTypeJ$ProbeCxt_Probe_extra_sel_uint256_pairLuint256_unitJ () -> _result {
        let offset
        offset := 1
        let _v54
        _v54 := 1
        let _v55
        let _v56
        _v56 := usr$CanStore_load$storageLuint256J(1)
        _v55 := _v56
        _result := _v55
        leave
      }
      function usr$RVA_acc$MemberAccessProxyLContractStorageLcxtJ_fieldSelector_loadType_offsetTypeJ$ProbeCxt_Probe_stored_sel_uint256_unit () -> _result {
        let offset
        offset := 0
        let _v57
        _v57 := 0
        let _v58
        let _v59
        _v59 := usr$CanStore_load$storageLuint256J(0)
        _v58 := _v59
        _result := _v58
        leave
      }
      function usr$RunContract_exec$ContractLmethods_fbJ$pairLMethodLDispatchNameTy_Probe_get_NonPayable_unit_uint256_t_get149048J_pairLMethodLDispatchNameTy_Probe_getExtra_NonPayable_unit_uint256_t_getExtra145106J_pairLMethodLDispatchNameTy_Probe_demandPositive_NonPayable_uint256_uint256_t_demandPositive152947J_MethodLDispatchNameTy_Probe_bareLit_NonPayable_uint256_uint256_t_bareLit156865JJJJ_FallbackLNonPayable_unit_unit_t_fallback_default_implementation91682J () {
        mstore(64, memoryguard(128))
        let _v60
        let _v61
        _v61 := usr$calldatasize()
        let _v62
        _v62 := usr$ge$word(_v61, 4)
        _v60 := _v62
        switch _v60
          case false {}
          case true {usr$RunDispatch_go$pairLn_mJ$MethodLDispatchNameTy_Probe_get_NonPayable_unit_uint256_t_get149048J_pairLMethodLDispatchNameTy_Probe_getExtra_NonPayable_unit_uint256_t_getExtra145106J_pairLMethodLDispatchNameTy_Probe_demandPositive_NonPayable_uint256_uint256_t_demandPositive152947J_MethodLDispatchNameTy_Probe_bareLit_NonPayable_uint256_uint256_t_bareLit156865JJJ()}
        usr$ExecMethod_exec$FallbackLpayability_unit_unit_fnJ$NonPayable_t_fallback_default_implementation91682()
      }
      function usr$RunDispatch_go$MethodLname_payability_args_rets_fnJ$DispatchNameTy_Probe_bareLit_NonPayable_uint256_uint256_t_bareLit156865 () {
        let _v63
        let _v64
        _v64 := usr$selector_matches$MethodLDispatchNameTy_Probe_bareLit_NonPayable_uint256_uint256_t_bareLit156865J()
        _v63 := _v64
        switch _v63
          case false {leave}
          case true {usr$ExecMethod_exec$MethodLname_NonPayable_args_rets_fnJ$DispatchNameTy_Probe_bareLit_uint256_uint256_t_bareLit156865()}
      }
      function usr$RunDispatch_go$pairLn_mJ$MethodLDispatchNameTy_Probe_demandPositive_NonPayable_uint256_uint256_t_demandPositive152947J_MethodLDispatchNameTy_Probe_bareLit_NonPayable_uint256_uint256_t_bareLit156865J () {
        let _v65
        let _v66
        _v66 := usr$selector_matches$MethodLDispatchNameTy_Probe_demandPositive_NonPayable_uint256_uint256_t_demandPositive152947J()
        _v65 := _v66
        switch _v65
          case false {usr$RunDispatch_go$MethodLname_payability_args_rets_fnJ$DispatchNameTy_Probe_bareLit_NonPayable_uint256_uint256_t_bareLit156865()}
          case true {usr$ExecMethod_exec$MethodLname_NonPayable_args_rets_fnJ$DispatchNameTy_Probe_demandPositive_uint256_uint256_t_demandPositive152947()}
      }
      function usr$RunDispatch_go$pairLn_mJ$MethodLDispatchNameTy_Probe_getExtra_NonPayable_unit_uint256_t_getExtra145106J_pairLMethodLDispatchNameTy_Probe_demandPositive_NonPayable_uint256_uint256_t_demandPositive152947J_MethodLDispatchNameTy_Probe_bareLit_NonPayable_uint256_uint256_t_bareLit156865JJ () {
        let _v67
        let _v68
        _v68 := usr$selector_matches$MethodLDispatchNameTy_Probe_getExtra_NonPayable_unit_uint256_t_getExtra145106J()
        _v67 := _v68
        switch _v67
          case false {usr$RunDispatch_go$pairLn_mJ$MethodLDispatchNameTy_Probe_demandPositive_NonPayable_uint256_uint256_t_demandPositive152947J_MethodLDispatchNameTy_Probe_bareLit_NonPayable_uint256_uint256_t_bareLit156865J()}
          case true {usr$ExecMethod_exec$MethodLname_NonPayable_args_rets_fnJ$DispatchNameTy_Probe_getExtra_unit_uint256_t_getExtra145106()}
      }
      function usr$RunDispatch_go$pairLn_mJ$MethodLDispatchNameTy_Probe_get_NonPayable_unit_uint256_t_get149048J_pairLMethodLDispatchNameTy_Probe_getExtra_NonPayable_unit_uint256_t_getExtra145106J_pairLMethodLDispatchNameTy_Probe_demandPositive_NonPayable_uint256_uint256_t_demandPositive152947J_MethodLDispatchNameTy_Probe_bareLit_NonPayable_uint256_uint256_t_bareLit156865JJJ () {
        let _v69
        let _v70
        _v70 := usr$selector_matches$MethodLDispatchNameTy_Probe_get_NonPayable_unit_uint256_t_get149048J()
        _v69 := _v70
        switch _v69
          case false {usr$RunDispatch_go$pairLn_mJ$MethodLDispatchNameTy_Probe_getExtra_NonPayable_unit_uint256_t_getExtra145106J_pairLMethodLDispatchNameTy_Probe_demandPositive_NonPayable_uint256_uint256_t_demandPositive152947J_MethodLDispatchNameTy_Probe_bareLit_NonPayable_uint256_uint256_t_bareLit156865JJ()}
          case true {usr$ExecMethod_exec$MethodLname_NonPayable_args_rets_fnJ$DispatchNameTy_Probe_get_unit_uint256_t_get149048()}
      }
      function usr$StorageType_load$uint256 (ptr) -> _result {
        let syntaxValue5
        let _v71
        _v71 := usr$StorageType_load$word(ptr)
        syntaxValue5 := _v71
        _result := syntaxValue5
        leave
      }
      function usr$StorageType_load$word (ptr) -> _result {
        let _v72
        _v72 := usr$sload(ptr)
        _result := _v72
        leave
      }
      function usr$Sub_sub$word (l, r) -> _result {
        let _v73
        _v73 := usr$subWord(l, r)
        _result := _v73
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
        let _v74
        _v74 := usr$WordReader_advance$CalldataWordReader(decoder, offset)
        _result := _v74
        leave
      }
      function usr$WordReader_advance$CalldataWordReader (reader, offset) -> _result {
        let _v75
        _v75 := usr$Add_add$word(reader, offset)
        _result := _v75
        leave
      }
      function usr$WordReader_read$ABIDecoderLty_readerJ$uint256_CalldataWordReader (decoder) -> _result {
        let _v76
        _v76 := usr$WordReader_read$CalldataWordReader(decoder)
        _result := _v76
        leave
      }
      function usr$WordReader_read$CalldataWordReader (reader) -> _result {
        let _v77
        _v77 := usr$calldataload(reader)
        _result := _v77
        leave
      }
      function usr$abi_decode$calldataLbytesJ_uint256_CalldataWordReader_uint256 (decodable) -> _result {
        let _v78
        let _v79
        _v79 := usr$HasWordReader_getWordReader$calldataLbytesJ(decodable)
        _v78 := _v79
        let _v80
        _v80 := usr$ABIDecode_decode$ABIDecoderLuint256_readerJ$CalldataWordReader(_v78, 0)
        _result := _v80
        leave
      }
      function usr$abi_encode$uint256 (val) -> _result {
        let ret
        let _v81
        _v81 := usr$get_free_memory()
        ret := _v81
        let start
        let _v82
        _v82 := usr$Add_add$word(ret, 32)
        start := _v82
        let tail
        let _v83
        _v83 := usr$Add_add$word(start, 32)
        let _v84
        _v84 := usr$ABIEncode_encodeInto$uint256(val, start, 0, _v83)
        tail := _v84
        let _v85
        _v85 := usr$Sub_sub$word(tail, start)
        usr$mstore(ret, _v85)
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
        let _v86
        _v86 := usr$add(l, r)
        _result := _v86
        leave
      }
      function usr$bareLit (x) -> _result {
        let _v87
        let _v88
        _v88 := usr$Ord_gt$uint256(x, 0)
        _v87 := _v88
        switch _v87
          case false {}
          case true {_result := 0
                     leave}
        _result := 1
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
      function usr$demandPositive (x) -> _result {
        let _v89
        _v89 := usr$Ord_gt$uint256(x, 0)
        let _v90
        let _v91
        let _v92
        _v90, _v91, _v92 := usr$Str_fromString$Error$ct0()
        usr$require(_v89, _v90, _v91, _v92)
        _result := x
        leave
      }
      function usr$do_exec$uint256_uint256_t_bareLit156865 () {
        let _v93
        _v93 := usr$calldatasize()
        let _v94
        _v94 := usr$ge$word(_v93, 36)
        usr$require(_v94, false, 140739926, 911)
        let _v95
        _v95 := 4
        let _v96
        let _v97
        _v97 := usr$abi_decode$calldataLbytesJ_uint256_CalldataWordReader_uint256(4)
        _v96 := _v97
        let _v98
        let _v99
        _v99 := usr$invokable_invoke$t_bareLit156865(_v96)
        _v98 := _v99
        let _v100
        let _v101
        _v101 := usr$abi_encode$uint256(_v98)
        _v100 := _v101
        let _v102
        _v102 := usr$MemoryPointer_ptr$memoryLbytesJ(_v100)
        let _v103
        _v103 := usr$MemorySize_len$memoryLbytesJ(_v100)
        usr$return_(_v102, _v103)
      }
      function usr$do_exec$uint256_uint256_t_demandPositive152947 () {
        let _v104
        _v104 := usr$calldatasize()
        let _v105
        _v105 := usr$ge$word(_v104, 36)
        usr$require(_v105, false, 140739926, 911)
        let _v106
        _v106 := 4
        let _v107
        let _v108
        _v108 := usr$abi_decode$calldataLbytesJ_uint256_CalldataWordReader_uint256(4)
        _v107 := _v108
        let _v109
        let _v110
        _v110 := usr$invokable_invoke$t_demandPositive152947(_v107)
        _v109 := _v110
        let _v111
        let _v112
        _v112 := usr$abi_encode$uint256(_v109)
        _v111 := _v112
        let _v113
        _v113 := usr$MemoryPointer_ptr$memoryLbytesJ(_v111)
        let _v114
        _v114 := usr$MemorySize_len$memoryLbytesJ(_v111)
        usr$return_(_v113, _v114)
      }
      function usr$do_exec$unit_uint256_t_get149048 () {
        let _v115
        _v115 := usr$calldatasize()
        let _v116
        _v116 := usr$ge$word(_v115, 4)
        usr$require(_v116, false, 140739926, 911)
        let _v117
        _v117 := 4
        let _v118
        let _v119
        _v119 := usr$invokable_invoke$t_get149048()
        _v118 := _v119
        let _v120
        let _v121
        _v121 := usr$abi_encode$uint256(_v118)
        _v120 := _v121
        let _v122
        _v122 := usr$MemoryPointer_ptr$memoryLbytesJ(_v120)
        let _v123
        _v123 := usr$MemorySize_len$memoryLbytesJ(_v120)
        usr$return_(_v122, _v123)
      }
      function usr$do_exec$unit_uint256_t_getExtra145106 () {
        let _v124
        _v124 := usr$calldatasize()
        let _v125
        _v125 := usr$ge$word(_v124, 4)
        usr$require(_v125, false, 140739926, 911)
        let _v126
        _v126 := 4
        let _v127
        let _v128
        _v128 := usr$invokable_invoke$t_getExtra145106()
        _v127 := _v128
        let _v129
        let _v130
        _v130 := usr$abi_encode$uint256(_v127)
        _v129 := _v130
        let _v131
        _v131 := usr$MemoryPointer_ptr$memoryLbytesJ(_v129)
        let _v132
        _v132 := usr$MemorySize_len$memoryLbytesJ(_v129)
        usr$return_(_v131, _v132)
      }
      function usr$eq (a, b) -> _result {
        let res
        res := eq(a, b)
        _result := res
        leave
      }
      function usr$eqWord (x, y) -> _v133 {
        let _v134
        _v134 := usr$eq(x, y)
        let _v135
        _v135 := usr$tobool(_v134)
        _v133 := _v135
        leave
      }
      function usr$fallback_default_implementation () {
        let _v136
        let _v137
        let _v138
        _v136 := false
        _v137 := 1227140848
        usr$revertWithError(false, 1227140848, 911)
      }
      function usr$ge$word (x, y) -> _v139 {
        let _v140
        _v140 := usr$le$word(y, x)
        _v139 := _v140
        leave
      }
      function usr$get () -> _result {
        let _v141
        _v141 := usr$RVA_acc$MemberAccessProxyLContractStorageLcxtJ_fieldSelector_loadType_offsetTypeJ$ProbeCxt_Probe_stored_sel_uint256_unit()
        _result := _v141
        leave
      }
      function usr$getExtra () -> _result {
        let _v142
        _v142 := usr$RVA_acc$MemberAccessProxyLContractStorageLcxtJ_fieldSelector_loadType_offsetTypeJ$ProbeCxt_Probe_extra_sel_uint256_pairLuint256_unitJ()
        _result := _v142
        leave
      }
      function usr$get_free_memory () -> _result {
        let _v143
        _v143 := usr$mload(64)
        _result := _v143
        leave
      }
      function usr$gtWord (x, y) -> _v144 {
        let _v145
        _v145 := usr$gt_(x, y)
        let _v146
        _v146 := usr$tobool(_v145)
        _v144 := _v146
        leave
      }
      function usr$gt_ (a, b) -> _result {
        let res
        res := gt(a, b)
        _result := res
        leave
      }
      function usr$invokable_invoke$t_bareLit156865 (arg156867) -> _result {
        let _v147
        _v147 := arg156867
        let _v148
        _v148 := usr$bareLit(_v147)
        _result := _v148
        leave
      }
      function usr$invokable_invoke$t_demandPositive152947 (arg152949) -> _result {
        let _v149
        _v149 := arg152949
        let _v150
        _v150 := usr$demandPositive(_v149)
        _result := _v150
        leave
      }
      function usr$invokable_invoke$t_fallback_default_implementation91682 () {
        usr$fallback_default_implementation()
        leave
      }
      function usr$invokable_invoke$t_get149048 () -> _result {
        let _v151
        _v151 := usr$get()
        _result := _v151
        leave
      }
      function usr$invokable_invoke$t_getExtra145106 () -> _result {
        let _v152
        _v152 := usr$getExtra()
        _result := _v152
        leave
      }
      function usr$le$word (x, y) -> _v153 {
        let _v154
        _v154 := usr$Ord_gt$word(x, y)
        let _v155
        _v155 := usr$not(_v154)
        _v153 := _v155
        leave
      }
      function usr$main () -> _v156 {
        usr$RunContract_exec$ContractLmethods_fbJ$pairLMethodLDispatchNameTy_Probe_get_NonPayable_unit_uint256_t_get149048J_pairLMethodLDispatchNameTy_Probe_getExtra_NonPayable_unit_uint256_t_getExtra145106J_pairLMethodLDispatchNameTy_Probe_demandPositive_NonPayable_uint256_uint256_t_demandPositive152947J_MethodLDispatchNameTy_Probe_bareLit_NonPayable_uint256_uint256_t_bareLit156865JJJJ_FallbackLNonPayable_unit_unit_t_fallback_default_implementation91682J()
      }
      function usr$mload (a) -> _result {
        let res
        res := mload(a)
        _result := res
        leave
      }
      function usr$mstore (a, b) { mstore(a, b) }
      function usr$not (_v157) -> _v158 {
        switch _v157
          case false {_v158 := true
                      leave}
          case true {_v158 := false
                     leave}
      }
      function usr$require (_v159, _v160, _v161, _v162) {
        let _v163
        let _v164
        _v164 := usr$not(_v159)
        _v163 := _v164
        switch _v163
          case false {}
          case true {usr$revertWithError(_v160, _v161, _v162)}
      }
      function usr$return_ (a, b) { return(a, b) }
      function usr$revertWithError (_v165, _v166, _v167) {
        switch _v165
          case false {usr$mstore(0, _v166)
                      usr$revert_(28, 4)}
          case true {switch _v166
                       case false {usr$revert_(0, 0)}
                       case true {let msg_
                                  let _v168
                                  _v168 := usr$Typedef_rep$memoryLtJ$string(_v167)
                                  msg_ := _v168
                                  let _v169
                                  _v169 := usr$Add_add$word(msg_, 32)
                                  let _v170
                                  _v170 := usr$mload(msg_)
                                  usr$revert_(_v169, _v170)}}
      }
      function usr$revert_ (a, b) { revert(a, b) }
      function usr$selector_matches$MethodLDispatchNameTy_Probe_bareLit_NonPayable_uint256_uint256_t_bareLit156865J () -> _v171 {
        let candidate
        candidate := 1155304837
        let selector
        let _v172
        _v172 := usr$calldataload(0)
        let _v173
        _v173 := usr$shr(224, _v172)
        selector := _v173
        let _v174
        _v174 := usr$Eq_eq$word(selector, 1155304837)
        _v171 := _v174
        leave
      }
      function usr$selector_matches$MethodLDispatchNameTy_Probe_demandPositive_NonPayable_uint256_uint256_t_demandPositive152947J () -> _v175 {
        let candidate
        candidate := 2218881575
        let selector
        let _v176
        _v176 := usr$calldataload(0)
        let _v177
        _v177 := usr$shr(224, _v176)
        selector := _v177
        let _v178
        _v178 := usr$Eq_eq$word(selector, 2218881575)
        _v175 := _v178
        leave
      }
      function usr$selector_matches$MethodLDispatchNameTy_Probe_getExtra_NonPayable_unit_uint256_t_getExtra145106J () -> _v179 {
        let candidate
        candidate := 1553095581
        let selector
        let _v180
        _v180 := usr$calldataload(0)
        let _v181
        _v181 := usr$shr(224, _v180)
        selector := _v181
        let _v182
        _v182 := usr$Eq_eq$word(selector, 1553095581)
        _v179 := _v182
        leave
      }
      function usr$selector_matches$MethodLDispatchNameTy_Probe_get_NonPayable_unit_uint256_t_get149048J () -> _v183 {
        let candidate
        candidate := 1833756220
        let selector
        let _v184
        _v184 := usr$calldataload(0)
        let _v185
        _v185 := usr$shr(224, _v184)
        selector := _v185
        let _v186
        _v186 := usr$Eq_eq$word(selector, 1833756220)
        _v183 := _v186
        leave
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
      function usr$sub (a, b) -> _result {
        let res
        res := sub(a, b)
        _result := res
        leave
      }
      function usr$subWord (l, r) -> _result {
        let _v187
        _v187 := usr$sub(l, r)
        _result := _v187
        leave
      }
      function usr$tobool (x) -> _v188 {
        switch x
          case 0 {_v188 := false
                  leave}
        default {_v188 := true
                 leave}
      }
      function usr$Str_fromString$Error$ct0 () -> _v189, _v190, _v191 {
        let _v192
        _v192 := usr$__strlit_0()
        _v189 := true
        _v190 := true
        _v191 := _v192
        leave
      }
      let _mainresult := usr$main()
      mstore(0, _mainresult)
      return(0, 32)
    }
  }
}