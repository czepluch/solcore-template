object "ProbeDeploy" {
  code {
    function usr$ABIDecode_decode$ABIDecoderLuint256_readerJ$MemoryWordReader (ptr, currentHeadOffset) -> _result {
      let _v0
      _v0 := usr$WordReader_advance$ABIDecoderLty_readerJ$uint256_MemoryWordReader(ptr, currentHeadOffset)
      let _v1
      _v1 := usr$WordReader_read$ABIDecoderLty_readerJ$uint256_MemoryWordReader(_v0)
      let _v2
      _v2 := usr$Typedef_abs$uint256(_v1)
      _result := _v2
      leave
    }
    function usr$Add_add$word (l, r) -> _result {
      let _v3
      _v3 := usr$addWord(l, r)
      _result := _v3
      leave
    }
    function usr$Assign_assign$a$storageLuint256J_uint256 (l, r) {
      usr$CanStore_store$storageLuint256J(l, r)
      leave
    }
    function usr$CanStore_store$storageLuint256J (l, r) {
      let _v4
      _v4 := usr$Typedef_rep$storageLtJ$uint256(l)
      usr$StorageType_store$uint256(_v4, r)
      leave
    }
    function usr$HasWordReader_getWordReader$memoryLbytesJ (x) -> _result {
      let _v5
      _v5 := usr$Typedef_rep$memoryLtJ$bytes(x)
      _result := _v5
      leave
    }
    function usr$StorageType_store$uint256 (ptr, value) {
      let _v6
      _v6 := usr$Typedef_rep$uint256(value)
      usr$StorageType_store$word(ptr, _v6)
      leave
    }
    function usr$StorageType_store$word (ptr, value) {
      usr$sstore(ptr, value)
      leave
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
      let _v7
      _v7 := usr$WordReader_advance$MemoryWordReader(decoder, offset)
      _result := _v7
      leave
    }
    function usr$WordReader_advance$MemoryWordReader (reader, offset) -> _result {
      let _v8
      _v8 := usr$Add_add$word(reader, offset)
      _result := _v8
      leave
    }
    function usr$WordReader_read$ABIDecoderLty_readerJ$uint256_MemoryWordReader (decoder) -> _result {
      let _v9
      _v9 := usr$WordReader_read$MemoryWordReader(decoder)
      _result := _v9
      leave
    }
    function usr$WordReader_read$MemoryWordReader (reader) -> _result {
      let _v10
      _v10 := usr$mload(reader)
      _result := _v10
      leave
    }
    function usr$_start () {
      mstore(64, memoryguard(128))
      if lt(codesize(), datasize("ProbeDeploy")) {revert(0, 0)}
      if callvalue() {mstore(0, 3046674083)
                      revert(28, 4)}
      let _v11
      let _v12
      _v12 := usr$copy_arguments_for_constructor()
      _v11 := _v12
      usr$invokable_invoke$t_init_128934(_v11)
      let size := datasize("Probe")
      codecopy(0, dataoffset("Probe"), datasize("Probe"))
      return(0, size)
    }
    function usr$abi_decode$memoryLbytesJ_uint256_MemoryWordReader_uint256 (decodable) -> _result {
      let _v13
      let _v14
      _v14 := usr$HasWordReader_getWordReader$memoryLbytesJ(decodable)
      _v13 := _v14
      let _v15
      _v15 := usr$ABIDecode_decode$ABIDecoderLuint256_readerJ$MemoryWordReader(_v13, 0)
      _result := _v15
      leave
    }
    function usr$add (a, b) -> _result {
      let res
      res := add(a, b)
      _result := res
      leave
    }
    function usr$addWord (l, r) -> _result {
      let _v16
      _v16 := usr$add(l, r)
      _result := _v16
      leave
    }
    function usr$copy_arguments_for_constructor () -> _result {
      let _v17
      let memoryDataOffset
      let programSize := datasize("ProbeDeploy")
      let argSize := sub(codesize(), programSize)
      memoryDataOffset := mload(64)
      mstore(64, add(memoryDataOffset, argSize))
      codecopy(memoryDataOffset, programSize, argSize)
      let _v18
      _v18 := memoryDataOffset
      let _v19
      _v19 := usr$abi_decode$memoryLbytesJ_uint256_MemoryWordReader_uint256(_v18)
      _v17 := _v19
      _result := _v17
      leave
    }
    function usr$init_ (x) {
      usr$Assign_assign$a$storageLuint256J_uint256(0, x)
    }
    function usr$invokable_invoke$t_init_128934 (arg128936) {
      let _v20
      _v20 := arg128936
      usr$init_(_v20)
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
        let _v21
        _v21 := usr$WordReader_advance$ABIDecoderLty_readerJ$uint256_CalldataWordReader(ptr, currentHeadOffset)
        let _v22
        _v22 := usr$WordReader_read$ABIDecoderLty_readerJ$uint256_CalldataWordReader(_v21)
        let _v23
        _v23 := usr$Typedef_abs$uint256(_v22)
        _result := _v23
        leave
      }
      function usr$ABIEncode_encodeInto$uint256 (x, basePtr, offset, tail) -> _result {
        let repx
        let _v24
        _v24 := usr$Typedef_rep$uint256(x)
        repx := _v24
        let _v25
        _v25 := usr$Add_add$word(basePtr, offset)
        usr$mstore(_v25, repx)
        _result := tail
        leave
      }
      function usr$Add_add$word (l, r) -> _result {
        let _v26
        _v26 := usr$addWord(l, r)
        _result := _v26
        leave
      }
      function usr$CanStore_load$storageLuint256J (l) -> _result {
        let _v27
        _v27 := usr$Typedef_rep$storageLtJ$uint256(l)
        let _v28
        _v28 := usr$StorageType_load$uint256(_v27)
        _result := _v28
        leave
      }
      function usr$Eq_eq$word (x, y) -> _v29 {
        let _v30
        _v30 := usr$eqWord(x, y)
        _v29 := _v30
        leave
      }
      function usr$ExecMethod_exec$FallbackLpayability_unit_unit_fnJ$NonPayable_t_fallback_default_implementation71925 () {
        usr$MethodLevelCallvalueCheck_checkCallvalue$NonPayable()
        usr$invokable_invoke$t_fallback_default_implementation71925()
        stop()
      }
      function usr$ExecMethod_exec$MethodLname_NonPayable_args_rets_fnJ$DispatchNameTy_Probe_bareLit_uint256_uint256_t_bareLit121731 () {
        usr$MethodLevelCallvalueCheck_checkCallvalue$NonPayable()
        usr$do_exec$uint256_uint256_t_bareLit121731()
      }
      function usr$ExecMethod_exec$MethodLname_NonPayable_args_rets_fnJ$DispatchNameTy_Probe_demandPositive_uint256_uint256_t_demandPositive118234 () {
        usr$MethodLevelCallvalueCheck_checkCallvalue$NonPayable()
        usr$do_exec$uint256_uint256_t_demandPositive118234()
      }
      function usr$ExecMethod_exec$MethodLname_NonPayable_args_rets_fnJ$DispatchNameTy_Probe_get_unit_uint256_t_get114756 () {
        usr$MethodLevelCallvalueCheck_checkCallvalue$NonPayable()
        usr$do_exec$unit_uint256_t_get114756()
      }
      function usr$HasWordReader_getWordReader$calldataLbytesJ (x) -> _result {
        let _v31
        _v31 := usr$Typedef_rep$calldataLtJ$bytes(x)
        _result := _v31
        leave
      }
      function usr$MethodLevelCallvalueCheck_checkCallvalue$NonPayable () {
        let _v32
        let _v33
        let _v34
        _v32 := false
        _v33 := 3046674083
        let _v35
        _v35 := usr$callvalue()
        let _v36
        _v36 := usr$Eq_eq$word(_v35, 0)
        usr$require(_v36, false, 3046674083, 911)
      }
      function usr$Ord_gt$uint256 (x, y) -> _v37 {
        let _v38
        _v38 := usr$Typedef_rep$uint256(x)
        let _v39
        _v39 := usr$Typedef_rep$uint256(y)
        let _v40
        _v40 := usr$Ord_gt$word(_v38, _v39)
        _v37 := _v40
        leave
      }
      function usr$Ord_gt$word (x, y) -> _v41 {
        let _v42
        _v42 := usr$gtWord(x, y)
        _v41 := _v42
        leave
      }
      function usr$RVA_acc$MemberAccessProxyLContractStorageLcxtJ_fieldSelector_loadType_offsetTypeJ$ProbeCxt_Probe_stored_sel_uint256_unit () -> _result {
        let offset
        offset := 0
        let _v43
        _v43 := usr$CanStore_load$storageLuint256J(0)
        _result := _v43
        leave
      }
      function usr$RunContract_exec$ContractLmethods_fbJ$pairLMethodLDispatchNameTy_Probe_get_NonPayable_unit_uint256_t_get114756J_pairLMethodLDispatchNameTy_Probe_demandPositive_NonPayable_uint256_uint256_t_demandPositive118234J_MethodLDispatchNameTy_Probe_bareLit_NonPayable_uint256_uint256_t_bareLit121731JJJ_FallbackLNonPayable_unit_unit_t_fallback_default_implementation71925J () {
        mstore(64, memoryguard(128))
        let _v44
        let _v45
        _v45 := usr$calldatasize()
        let _v46
        _v46 := usr$ge$word(_v45, 4)
        _v44 := _v46
        switch _v44
          case false {}
          case true {usr$RunDispatch_go$pairLn_mJ$MethodLDispatchNameTy_Probe_get_NonPayable_unit_uint256_t_get114756J_pairLMethodLDispatchNameTy_Probe_demandPositive_NonPayable_uint256_uint256_t_demandPositive118234J_MethodLDispatchNameTy_Probe_bareLit_NonPayable_uint256_uint256_t_bareLit121731JJ()}
        usr$ExecMethod_exec$FallbackLpayability_unit_unit_fnJ$NonPayable_t_fallback_default_implementation71925()
      }
      function usr$RunDispatch_go$MethodLname_payability_args_rets_fnJ$DispatchNameTy_Probe_bareLit_NonPayable_uint256_uint256_t_bareLit121731 () {
        let _v47
        let _v48
        _v48 := usr$selector_matches$MethodLDispatchNameTy_Probe_bareLit_NonPayable_uint256_uint256_t_bareLit121731J()
        _v47 := _v48
        switch _v47
          case false {leave}
          case true {usr$ExecMethod_exec$MethodLname_NonPayable_args_rets_fnJ$DispatchNameTy_Probe_bareLit_uint256_uint256_t_bareLit121731()}
      }
      function usr$RunDispatch_go$pairLn_mJ$MethodLDispatchNameTy_Probe_demandPositive_NonPayable_uint256_uint256_t_demandPositive118234J_MethodLDispatchNameTy_Probe_bareLit_NonPayable_uint256_uint256_t_bareLit121731J () {
        let _v49
        let _v50
        _v50 := usr$selector_matches$MethodLDispatchNameTy_Probe_demandPositive_NonPayable_uint256_uint256_t_demandPositive118234J()
        _v49 := _v50
        switch _v49
          case false {usr$RunDispatch_go$MethodLname_payability_args_rets_fnJ$DispatchNameTy_Probe_bareLit_NonPayable_uint256_uint256_t_bareLit121731()}
          case true {usr$ExecMethod_exec$MethodLname_NonPayable_args_rets_fnJ$DispatchNameTy_Probe_demandPositive_uint256_uint256_t_demandPositive118234()}
      }
      function usr$RunDispatch_go$pairLn_mJ$MethodLDispatchNameTy_Probe_get_NonPayable_unit_uint256_t_get114756J_pairLMethodLDispatchNameTy_Probe_demandPositive_NonPayable_uint256_uint256_t_demandPositive118234J_MethodLDispatchNameTy_Probe_bareLit_NonPayable_uint256_uint256_t_bareLit121731JJ () {
        let _v51
        let _v52
        _v52 := usr$selector_matches$MethodLDispatchNameTy_Probe_get_NonPayable_unit_uint256_t_get114756J()
        _v51 := _v52
        switch _v51
          case false {usr$RunDispatch_go$pairLn_mJ$MethodLDispatchNameTy_Probe_demandPositive_NonPayable_uint256_uint256_t_demandPositive118234J_MethodLDispatchNameTy_Probe_bareLit_NonPayable_uint256_uint256_t_bareLit121731J()}
          case true {usr$ExecMethod_exec$MethodLname_NonPayable_args_rets_fnJ$DispatchNameTy_Probe_get_unit_uint256_t_get114756()}
      }
      function usr$StorageType_load$uint256 (ptr) -> _result {
        let _v53
        _v53 := usr$StorageType_load$word(ptr)
        _result := _v53
        leave
      }
      function usr$StorageType_load$word (ptr) -> _result {
        let _v54
        _v54 := usr$sload(ptr)
        _result := _v54
        leave
      }
      function usr$Sub_sub$word (l, r) -> _result {
        let _v55
        _v55 := usr$subWord(l, r)
        _result := _v55
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
        let _v56
        _v56 := usr$WordReader_advance$CalldataWordReader(decoder, offset)
        _result := _v56
        leave
      }
      function usr$WordReader_advance$CalldataWordReader (reader, offset) -> _result {
        let _v57
        _v57 := usr$Add_add$word(reader, offset)
        _result := _v57
        leave
      }
      function usr$WordReader_read$ABIDecoderLty_readerJ$uint256_CalldataWordReader (decoder) -> _result {
        let _v58
        _v58 := usr$WordReader_read$CalldataWordReader(decoder)
        _result := _v58
        leave
      }
      function usr$WordReader_read$CalldataWordReader (reader) -> _result {
        let _v59
        _v59 := usr$calldataload(reader)
        _result := _v59
        leave
      }
      function usr$abi_decode$calldataLbytesJ_uint256_CalldataWordReader_uint256 (decodable) -> _result {
        let _v60
        let _v61
        _v61 := usr$HasWordReader_getWordReader$calldataLbytesJ(decodable)
        _v60 := _v61
        let _v62
        _v62 := usr$ABIDecode_decode$ABIDecoderLuint256_readerJ$CalldataWordReader(_v60, 0)
        _result := _v62
        leave
      }
      function usr$abi_encode$uint256 (val) -> _result {
        let free
        let _v63
        _v63 := usr$get_free_memory()
        free := _v63
        let tail
        let _v64
        _v64 := usr$Add_add$word(free, 32)
        let _v65
        _v65 := usr$ABIEncode_encodeInto$uint256(val, free, 0, _v64)
        tail := _v65
        usr$set_free_memory(tail)
        _result := free
        leave
      }
      function usr$add (a, b) -> _result {
        let res
        res := add(a, b)
        _result := res
        leave
      }
      function usr$addWord (l, r) -> _result {
        let _v66
        _v66 := usr$add(l, r)
        _result := _v66
        leave
      }
      function usr$bareLit (x) -> _result {
        let _v67
        let _v68
        _v68 := usr$Ord_gt$uint256(x, 0)
        _v67 := _v68
        switch _v67
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
        let _v69
        _v69 := usr$Ord_gt$uint256(x, 0)
        let _v70
        let _v71
        let _v72
        _v70, _v71, _v72 := usr$Str_fromString$Error$ct0()
        usr$require(_v69, _v70, _v71, _v72)
        _result := x
        leave
      }
      function usr$do_exec$uint256_uint256_t_bareLit121731 () {
        let _v73
        _v73 := usr$calldatasize()
        let _v74
        _v74 := usr$ge$word(_v73, 36)
        usr$require(_v74, false, 140739926, 911)
        let _v75
        _v75 := 4
        let _v76
        let _v77
        _v77 := usr$abi_decode$calldataLbytesJ_uint256_CalldataWordReader_uint256(4)
        _v76 := _v77
        let _v78
        let _v79
        _v79 := usr$invokable_invoke$t_bareLit121731(_v76)
        _v78 := _v79
        let _v80
        let _v81
        _v81 := usr$abi_encode$uint256(_v78)
        _v80 := _v81
        let start
        let _v82
        _v82 := usr$Typedef_rep$memoryLtJ$bytes(_v80)
        start := _v82
        let end
        let _v83
        _v83 := usr$get_free_memory()
        end := _v83
        let retSz
        let _v84
        _v84 := usr$Sub_sub$word(end, start)
        retSz := _v84
        return(start, retSz)
      }
      function usr$do_exec$uint256_uint256_t_demandPositive118234 () {
        let _v85
        _v85 := usr$calldatasize()
        let _v86
        _v86 := usr$ge$word(_v85, 36)
        usr$require(_v86, false, 140739926, 911)
        let _v87
        _v87 := 4
        let _v88
        let _v89
        _v89 := usr$abi_decode$calldataLbytesJ_uint256_CalldataWordReader_uint256(4)
        _v88 := _v89
        let _v90
        let _v91
        _v91 := usr$invokable_invoke$t_demandPositive118234(_v88)
        _v90 := _v91
        let _v92
        let _v93
        _v93 := usr$abi_encode$uint256(_v90)
        _v92 := _v93
        let start
        let _v94
        _v94 := usr$Typedef_rep$memoryLtJ$bytes(_v92)
        start := _v94
        let end
        let _v95
        _v95 := usr$get_free_memory()
        end := _v95
        let retSz
        let _v96
        _v96 := usr$Sub_sub$word(end, start)
        retSz := _v96
        return(start, retSz)
      }
      function usr$do_exec$unit_uint256_t_get114756 () {
        let _v97
        _v97 := usr$calldatasize()
        let _v98
        _v98 := usr$ge$word(_v97, 4)
        usr$require(_v98, false, 140739926, 911)
        let _v99
        _v99 := 4
        let _v100
        let _v101
        _v101 := usr$invokable_invoke$t_get114756()
        _v100 := _v101
        let _v102
        let _v103
        _v103 := usr$abi_encode$uint256(_v100)
        _v102 := _v103
        let start
        let _v104
        _v104 := usr$Typedef_rep$memoryLtJ$bytes(_v102)
        start := _v104
        let end
        let _v105
        _v105 := usr$get_free_memory()
        end := _v105
        let retSz
        let _v106
        _v106 := usr$Sub_sub$word(end, start)
        retSz := _v106
        return(start, retSz)
      }
      function usr$eq (a, b) -> _result {
        let res
        res := eq(a, b)
        _result := res
        leave
      }
      function usr$eqWord (x, y) -> _v107 {
        let _v108
        _v108 := usr$eq(x, y)
        let _v109
        _v109 := usr$tobool(_v108)
        _v107 := _v109
        leave
      }
      function usr$fallback_default_implementation () {
        let _v110
        let _v111
        let _v112
        _v110 := false
        _v111 := 1227140848
        usr$revertWithError(false, 1227140848, 911)
      }
      function usr$ge$word (x, y) -> _v113 {
        let _v114
        _v114 := usr$le$word(y, x)
        _v113 := _v114
        leave
      }
      function usr$get () -> _result {
        let _v115
        _v115 := usr$RVA_acc$MemberAccessProxyLContractStorageLcxtJ_fieldSelector_loadType_offsetTypeJ$ProbeCxt_Probe_stored_sel_uint256_unit()
        _result := _v115
        leave
      }
      function usr$get_free_memory () -> _result {
        let _v116
        _v116 := usr$mload(64)
        _result := _v116
        leave
      }
      function usr$gtWord (x, y) -> _v117 {
        let _v118
        _v118 := usr$gt_(x, y)
        let _v119
        _v119 := usr$tobool(_v118)
        _v117 := _v119
        leave
      }
      function usr$gt_ (a, b) -> _result {
        let res
        res := gt(a, b)
        _result := res
        leave
      }
      function usr$invokable_invoke$t_bareLit121731 (arg121733) -> _result {
        let _v120
        _v120 := arg121733
        let _v121
        _v121 := usr$bareLit(_v120)
        _result := _v121
        leave
      }
      function usr$invokable_invoke$t_demandPositive118234 (arg118236) -> _result {
        let _v122
        _v122 := arg118236
        let _v123
        _v123 := usr$demandPositive(_v122)
        _result := _v123
        leave
      }
      function usr$invokable_invoke$t_fallback_default_implementation71925 () {
        usr$fallback_default_implementation()
        leave
      }
      function usr$invokable_invoke$t_get114756 () -> _result {
        let _v124
        _v124 := usr$get()
        _result := _v124
        leave
      }
      function usr$le$word (x, y) -> _v125 {
        let _v126
        _v126 := usr$Ord_gt$word(x, y)
        let _v127
        _v127 := usr$not(_v126)
        _v125 := _v127
        leave
      }
      function usr$main () -> _v128 {
        usr$RunContract_exec$ContractLmethods_fbJ$pairLMethodLDispatchNameTy_Probe_get_NonPayable_unit_uint256_t_get114756J_pairLMethodLDispatchNameTy_Probe_demandPositive_NonPayable_uint256_uint256_t_demandPositive118234J_MethodLDispatchNameTy_Probe_bareLit_NonPayable_uint256_uint256_t_bareLit121731JJJ_FallbackLNonPayable_unit_unit_t_fallback_default_implementation71925J()
      }
      function usr$mload (a) -> _result {
        let res
        res := mload(a)
        _result := res
        leave
      }
      function usr$mstore (a, b) { mstore(a, b) }
      function usr$not (_v129) -> _v130 {
        switch _v129
          case false {_v130 := true
                      leave}
          case true {_v130 := false
                     leave}
      }
      function usr$require (_v131, _v132, _v133, _v134) {
        let _v135
        let _v136
        _v136 := usr$not(_v131)
        _v135 := _v136
        switch _v135
          case false {}
          case true {usr$revertWithError(_v132, _v133, _v134)}
      }
      function usr$revertWithError (_v137, _v138, _v139) {
        switch _v137
          case false {usr$mstore(0, _v138)
                      usr$revert_(28, 4)}
          case true {switch _v138
                       case false {usr$revert_(0, 0)}
                       case true {let msg_
                                  let _v140
                                  _v140 := usr$Typedef_rep$memoryLtJ$string(_v139)
                                  msg_ := _v140
                                  let _v141
                                  _v141 := usr$Add_add$word(msg_, 32)
                                  let _v142
                                  _v142 := usr$mload(msg_)
                                  usr$revert_(_v141, _v142)}}
      }
      function usr$revert_ (a, b) { revert(a, b) }
      function usr$selector_matches$MethodLDispatchNameTy_Probe_bareLit_NonPayable_uint256_uint256_t_bareLit121731J () -> _v143 {
        let candidate
        candidate := 1155304837
        let selector
        let _v144
        _v144 := usr$calldataload(0)
        let _v145
        _v145 := usr$shr(224, _v144)
        selector := _v145
        let _v146
        _v146 := usr$Eq_eq$word(selector, 1155304837)
        _v143 := _v146
        leave
      }
      function usr$selector_matches$MethodLDispatchNameTy_Probe_demandPositive_NonPayable_uint256_uint256_t_demandPositive118234J () -> _v147 {
        let candidate
        candidate := 2218881575
        let selector
        let _v148
        _v148 := usr$calldataload(0)
        let _v149
        _v149 := usr$shr(224, _v148)
        selector := _v149
        let _v150
        _v150 := usr$Eq_eq$word(selector, 2218881575)
        _v147 := _v150
        leave
      }
      function usr$selector_matches$MethodLDispatchNameTy_Probe_get_NonPayable_unit_uint256_t_get114756J () -> _v151 {
        let candidate
        candidate := 1833756220
        let selector
        let _v152
        _v152 := usr$calldataload(0)
        let _v153
        _v153 := usr$shr(224, _v152)
        selector := _v153
        let _v154
        _v154 := usr$Eq_eq$word(selector, 1833756220)
        _v151 := _v154
        leave
      }
      function usr$set_free_memory (loc) {
        usr$mstore(64, loc)
        leave
      }
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
        let _v155
        _v155 := usr$sub(l, r)
        _result := _v155
        leave
      }
      function usr$tobool (x) -> _v156 {
        switch x
          case 0 {_v156 := false
                  leave}
        default {_v156 := true
                 leave}
      }
      function usr$Str_fromString$Error$ct0 () -> _v157, _v158, _v159 {
        let _v160
        _v160 := usr$__strlit_0()
        _v157 := true
        _v158 := true
        _v159 := _v160
        leave
      }
      let _mainresult := usr$main()
      mstore(0, _mainresult)
      return(0, 32)
    }
  }
}