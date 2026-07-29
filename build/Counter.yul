object "CounterDeploy" {
  code {
    function usr$_start () {
      mstore(64, memoryguard(128))
      if lt(codesize(), datasize("CounterDeploy")) {revert(0, 0)}
      if callvalue() {mstore(0, 3046674083)
                      revert(28, 4)}
      usr$invokable_invoke$t_init_138170()
      let size := datasize("Counter")
      codecopy(0, dataoffset("Counter"), datasize("Counter"))
      return(0, size)
    }
    function usr$init_ () { }
    function usr$invokable_invoke$t_init_138170 () {
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
        _v0 := usr$WordReader_advance$ABIDecoderLty_readerJ$uint256_CalldataWordReader(ptr, currentHeadOffset)
        let _v1
        _v1 := usr$WordReader_read$ABIDecoderLty_readerJ$uint256_CalldataWordReader(_v0)
        let _v2
        _v2 := usr$Typedef_abs$uint256(_v1)
        _result := _v2
        leave
      }
      function usr$ABIEncode_encodeInto$uint256 (x, basePtr, offset, tail) -> _result {
        let repx
        let _v3
        _v3 := usr$Typedef_rep$uint256(x)
        repx := _v3
        let _v4
        _v4 := usr$Add_add$word(basePtr, offset)
        usr$mstore(_v4, repx)
        _result := tail
        leave
      }
      function usr$ABIEncode_encodeInto$unit (basePtr, offset, tail) -> _result {
        _result := tail
        leave
      }
      function usr$Add_add$uint256 (x, y) -> _result {
        let _v5
        _v5 := usr$Typedef_rep$uint256(x)
        let _v6
        _v6 := usr$Typedef_rep$uint256(y)
        let _v7
        _v7 := usr$Add_add$word(_v5, _v6)
        let _v8
        _v8 := usr$Typedef_abs$uint256(_v7)
        _result := _v8
        leave
      }
      function usr$Add_add$word (l, r) -> _result {
        let _v9
        _v9 := usr$addWord(l, r)
        _result := _v9
        leave
      }
      function usr$Assign_assign$a$storageLuint256J_uint256 (l, r) {
        usr$CanStore_store$storageLuint256J(l, r)
        leave
      }
      function usr$CanStore_load$storageLuint256J (l) -> _result {
        let _v10
        _v10 := usr$Typedef_rep$storageLtJ$uint256(l)
        let _v11
        _v11 := usr$StorageType_load$uint256(_v10)
        _result := _v11
        leave
      }
      function usr$CanStore_store$storageLuint256J (l, r) {
        let _v12
        _v12 := usr$Typedef_rep$storageLtJ$uint256(l)
        usr$StorageType_store$uint256(_v12, r)
        leave
      }
      function usr$Eq_eq$word (x, y) -> _v13 {
        let _v14
        _v14 := usr$eqWord(x, y)
        _v13 := _v14
        leave
      }
      function usr$ExecMethod_exec$FallbackLpayability_unit_unit_fnJ$NonPayable_t_fallback_default_implementation74113 () {
        usr$MethodLevelCallvalueCheck_checkCallvalue$NonPayable()
        usr$invokable_invoke$t_fallback_default_implementation74113()
        stop()
      }
      function usr$ExecMethod_exec$MethodLname_NonPayable_args_rets_fnJ$DispatchNameTy_Counter_decrement_unit_unit_t_decrement130840 () {
        usr$MethodLevelCallvalueCheck_checkCallvalue$NonPayable()
        usr$do_exec$unit_unit_t_decrement130840()
      }
      function usr$ExecMethod_exec$MethodLname_NonPayable_args_rets_fnJ$DispatchNameTy_Counter_increment_unit_unit_t_increment126989 () {
        usr$MethodLevelCallvalueCheck_checkCallvalue$NonPayable()
        usr$do_exec$unit_unit_t_increment126989()
      }
      function usr$ExecMethod_exec$MethodLname_NonPayable_args_rets_fnJ$DispatchNameTy_Counter_number_unit_uint256_t_number123248 () {
        usr$MethodLevelCallvalueCheck_checkCallvalue$NonPayable()
        usr$do_exec$unit_uint256_t_number123248()
      }
      function usr$ExecMethod_exec$MethodLname_NonPayable_args_rets_fnJ$DispatchNameTy_Counter_setNumber_uint256_unit_t_setNumber119630 () {
        usr$MethodLevelCallvalueCheck_checkCallvalue$NonPayable()
        usr$do_exec$uint256_unit_t_setNumber119630()
      }
      function usr$HasWordReader_getWordReader$calldataLbytesJ (x) -> _result {
        let _v15
        _v15 := usr$Typedef_rep$calldataLtJ$bytes(x)
        _result := _v15
        leave
      }
      function usr$MethodLevelCallvalueCheck_checkCallvalue$NonPayable () {
        let _v16
        let _v17
        let _v18
        _v16 := false
        _v17 := 3046674083
        let _v19
        _v19 := usr$callvalue()
        let _v20
        _v20 := usr$Eq_eq$word(_v19, 0)
        usr$require(_v20, false, 3046674083, 911)
      }
      function usr$Ord_gt$uint256 (x, y) -> _v21 {
        let _v22
        _v22 := usr$Typedef_rep$uint256(x)
        let _v23
        _v23 := usr$Typedef_rep$uint256(y)
        let _v24
        _v24 := usr$Ord_gt$word(_v22, _v23)
        _v21 := _v24
        leave
      }
      function usr$Ord_gt$word (x, y) -> _v25 {
        let _v26
        _v26 := usr$gtWord(x, y)
        _v25 := _v26
        leave
      }
      function usr$RVA_acc$MemberAccessProxyLContractStorageLcxtJ_fieldSelector_loadType_offsetTypeJ$CounterCxt_Counter_number_sel_uint256_unit () -> _result {
        let offset
        offset := 0
        let _v27
        _v27 := usr$CanStore_load$storageLuint256J(0)
        _result := _v27
        leave
      }
      function usr$RunContract_exec$ContractLmethods_fbJ$pairLMethodLDispatchNameTy_Counter_number_NonPayable_unit_uint256_t_number123248J_pairLMethodLDispatchNameTy_Counter_setNumber_NonPayable_uint256_unit_t_setNumber119630J_pairLMethodLDispatchNameTy_Counter_increment_NonPayable_unit_unit_t_increment126989J_MethodLDispatchNameTy_Counter_decrement_NonPayable_unit_unit_t_decrement130840JJJJ_FallbackLNonPayable_unit_unit_t_fallback_default_implementation74113J () {
        mstore(64, memoryguard(128))
        let _v28
        let _v29
        _v29 := usr$calldatasize()
        let _v30
        _v30 := usr$ge$word(_v29, 4)
        _v28 := _v30
        switch _v28
          case false {}
          case true {usr$RunDispatch_go$pairLn_mJ$MethodLDispatchNameTy_Counter_number_NonPayable_unit_uint256_t_number123248J_pairLMethodLDispatchNameTy_Counter_setNumber_NonPayable_uint256_unit_t_setNumber119630J_pairLMethodLDispatchNameTy_Counter_increment_NonPayable_unit_unit_t_increment126989J_MethodLDispatchNameTy_Counter_decrement_NonPayable_unit_unit_t_decrement130840JJJ()}
        usr$ExecMethod_exec$FallbackLpayability_unit_unit_fnJ$NonPayable_t_fallback_default_implementation74113()
      }
      function usr$RunDispatch_go$MethodLname_payability_args_rets_fnJ$DispatchNameTy_Counter_decrement_NonPayable_unit_unit_t_decrement130840 () {
        let _v31
        let _v32
        _v32 := usr$selector_matches$MethodLDispatchNameTy_Counter_decrement_NonPayable_unit_unit_t_decrement130840J()
        _v31 := _v32
        switch _v31
          case false {leave}
          case true {usr$ExecMethod_exec$MethodLname_NonPayable_args_rets_fnJ$DispatchNameTy_Counter_decrement_unit_unit_t_decrement130840()}
      }
      function usr$RunDispatch_go$pairLn_mJ$MethodLDispatchNameTy_Counter_increment_NonPayable_unit_unit_t_increment126989J_MethodLDispatchNameTy_Counter_decrement_NonPayable_unit_unit_t_decrement130840J () {
        let _v33
        let _v34
        _v34 := usr$selector_matches$MethodLDispatchNameTy_Counter_increment_NonPayable_unit_unit_t_increment126989J()
        _v33 := _v34
        switch _v33
          case false {usr$RunDispatch_go$MethodLname_payability_args_rets_fnJ$DispatchNameTy_Counter_decrement_NonPayable_unit_unit_t_decrement130840()}
          case true {usr$ExecMethod_exec$MethodLname_NonPayable_args_rets_fnJ$DispatchNameTy_Counter_increment_unit_unit_t_increment126989()}
      }
      function usr$RunDispatch_go$pairLn_mJ$MethodLDispatchNameTy_Counter_number_NonPayable_unit_uint256_t_number123248J_pairLMethodLDispatchNameTy_Counter_setNumber_NonPayable_uint256_unit_t_setNumber119630J_pairLMethodLDispatchNameTy_Counter_increment_NonPayable_unit_unit_t_increment126989J_MethodLDispatchNameTy_Counter_decrement_NonPayable_unit_unit_t_decrement130840JJJ () {
        let _v35
        let _v36
        _v36 := usr$selector_matches$MethodLDispatchNameTy_Counter_number_NonPayable_unit_uint256_t_number123248J()
        _v35 := _v36
        switch _v35
          case false {usr$RunDispatch_go$pairLn_mJ$MethodLDispatchNameTy_Counter_setNumber_NonPayable_uint256_unit_t_setNumber119630J_pairLMethodLDispatchNameTy_Counter_increment_NonPayable_unit_unit_t_increment126989J_MethodLDispatchNameTy_Counter_decrement_NonPayable_unit_unit_t_decrement130840JJ()}
          case true {usr$ExecMethod_exec$MethodLname_NonPayable_args_rets_fnJ$DispatchNameTy_Counter_number_unit_uint256_t_number123248()}
      }
      function usr$RunDispatch_go$pairLn_mJ$MethodLDispatchNameTy_Counter_setNumber_NonPayable_uint256_unit_t_setNumber119630J_pairLMethodLDispatchNameTy_Counter_increment_NonPayable_unit_unit_t_increment126989J_MethodLDispatchNameTy_Counter_decrement_NonPayable_unit_unit_t_decrement130840JJ () {
        let _v37
        let _v38
        _v38 := usr$selector_matches$MethodLDispatchNameTy_Counter_setNumber_NonPayable_uint256_unit_t_setNumber119630J()
        _v37 := _v38
        switch _v37
          case false {usr$RunDispatch_go$pairLn_mJ$MethodLDispatchNameTy_Counter_increment_NonPayable_unit_unit_t_increment126989J_MethodLDispatchNameTy_Counter_decrement_NonPayable_unit_unit_t_decrement130840J()}
          case true {usr$ExecMethod_exec$MethodLname_NonPayable_args_rets_fnJ$DispatchNameTy_Counter_setNumber_uint256_unit_t_setNumber119630()}
      }
      function usr$StorageType_load$uint256 (ptr) -> _result {
        let _v39
        _v39 := usr$StorageType_load$word(ptr)
        _result := _v39
        leave
      }
      function usr$StorageType_load$word (ptr) -> _result {
        let _v40
        _v40 := usr$sload(ptr)
        _result := _v40
        leave
      }
      function usr$StorageType_store$uint256 (ptr, value) {
        let _v41
        _v41 := usr$Typedef_rep$uint256(value)
        usr$StorageType_store$word(ptr, _v41)
        leave
      }
      function usr$StorageType_store$word (ptr, value) {
        usr$sstore(ptr, value)
        leave
      }
      function usr$Sub_sub$uint256 (x, y) -> _result {
        let _v42
        _v42 := usr$Typedef_rep$uint256(x)
        let _v43
        _v43 := usr$Typedef_rep$uint256(y)
        let _v44
        _v44 := usr$Sub_sub$word(_v42, _v43)
        let _v45
        _v45 := usr$Typedef_abs$uint256(_v44)
        _result := _v45
        leave
      }
      function usr$Sub_sub$word (l, r) -> _result {
        let _v46
        _v46 := usr$subWord(l, r)
        _result := _v46
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
        let _v47
        _v47 := usr$WordReader_advance$CalldataWordReader(decoder, offset)
        _result := _v47
        leave
      }
      function usr$WordReader_advance$CalldataWordReader (reader, offset) -> _result {
        let _v48
        _v48 := usr$Add_add$word(reader, offset)
        _result := _v48
        leave
      }
      function usr$WordReader_read$ABIDecoderLty_readerJ$uint256_CalldataWordReader (decoder) -> _result {
        let _v49
        _v49 := usr$WordReader_read$CalldataWordReader(decoder)
        _result := _v49
        leave
      }
      function usr$WordReader_read$CalldataWordReader (reader) -> _result {
        let _v50
        _v50 := usr$calldataload(reader)
        _result := _v50
        leave
      }
      function usr$abi_decode$calldataLbytesJ_uint256_CalldataWordReader_uint256 (decodable) -> _result {
        let _v51
        let _v52
        _v52 := usr$HasWordReader_getWordReader$calldataLbytesJ(decodable)
        _v51 := _v52
        let _v53
        _v53 := usr$ABIDecode_decode$ABIDecoderLuint256_readerJ$CalldataWordReader(_v51, 0)
        _result := _v53
        leave
      }
      function usr$abi_encode$uint256 (val) -> _result {
        let free
        let _v54
        _v54 := usr$get_free_memory()
        free := _v54
        let tail
        let _v55
        _v55 := usr$Add_add$word(free, 32)
        let _v56
        _v56 := usr$ABIEncode_encodeInto$uint256(val, free, 0, _v55)
        tail := _v56
        usr$set_free_memory(tail)
        _result := free
        leave
      }
      function usr$abi_encode$unit () -> _result {
        let free
        let _v57
        _v57 := usr$get_free_memory()
        free := _v57
        let tail
        let _v58
        _v58 := usr$Add_add$word(free, 0)
        let _v59
        _v59 := usr$ABIEncode_encodeInto$unit(free, 0, _v58)
        tail := _v59
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
        let _v60
        _v60 := usr$add(l, r)
        _result := _v60
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
        let _v61
        _v61 := usr$RVA_acc$MemberAccessProxyLContractStorageLcxtJ_fieldSelector_loadType_offsetTypeJ$CounterCxt_Counter_number_sel_uint256_unit()
        let _v62
        _v62 := usr$Ord_gt$uint256(_v61, 0)
        let _v63
        let _v64
        let _v65
        _v63, _v64, _v65 := usr$Str_fromString$Error$ct0()
        usr$require(_v62, _v63, _v64, _v65)
        let _v66
        _v66 := usr$RVA_acc$MemberAccessProxyLContractStorageLcxtJ_fieldSelector_loadType_offsetTypeJ$CounterCxt_Counter_number_sel_uint256_unit()
        let _v67
        _v67 := usr$Sub_sub$uint256(_v66, 1)
        usr$Assign_assign$a$storageLuint256J_uint256(0, _v67)
      }
      function usr$do_exec$uint256_unit_t_setNumber119630 () {
        let _v68
        _v68 := usr$calldatasize()
        let _v69
        _v69 := usr$ge$word(_v68, 36)
        usr$require(_v69, false, 140739926, 911)
        let _v70
        _v70 := 4
        let _v71
        let _v72
        _v72 := usr$abi_decode$calldataLbytesJ_uint256_CalldataWordReader_uint256(4)
        _v71 := _v72
        usr$invokable_invoke$t_setNumber119630(_v71)
        let _v73
        let _v74
        _v74 := usr$abi_encode$unit()
        _v73 := _v74
        let start
        let _v75
        _v75 := usr$Typedef_rep$memoryLtJ$bytes(_v73)
        start := _v75
        let end
        let _v76
        _v76 := usr$get_free_memory()
        end := _v76
        let retSz
        let _v77
        _v77 := usr$Sub_sub$word(end, start)
        retSz := _v77
        return(start, retSz)
      }
      function usr$do_exec$unit_uint256_t_number123248 () {
        let _v78
        _v78 := usr$calldatasize()
        let _v79
        _v79 := usr$ge$word(_v78, 4)
        usr$require(_v79, false, 140739926, 911)
        let _v80
        _v80 := 4
        let _v81
        let _v82
        _v82 := usr$invokable_invoke$t_number123248()
        _v81 := _v82
        let _v83
        let _v84
        _v84 := usr$abi_encode$uint256(_v81)
        _v83 := _v84
        let start
        let _v85
        _v85 := usr$Typedef_rep$memoryLtJ$bytes(_v83)
        start := _v85
        let end
        let _v86
        _v86 := usr$get_free_memory()
        end := _v86
        let retSz
        let _v87
        _v87 := usr$Sub_sub$word(end, start)
        retSz := _v87
        return(start, retSz)
      }
      function usr$do_exec$unit_unit_t_decrement130840 () {
        let _v88
        _v88 := usr$calldatasize()
        let _v89
        _v89 := usr$ge$word(_v88, 4)
        usr$require(_v89, false, 140739926, 911)
        let _v90
        _v90 := 4
        usr$invokable_invoke$t_decrement130840()
        let _v91
        let _v92
        _v92 := usr$abi_encode$unit()
        _v91 := _v92
        let start
        let _v93
        _v93 := usr$Typedef_rep$memoryLtJ$bytes(_v91)
        start := _v93
        let end
        let _v94
        _v94 := usr$get_free_memory()
        end := _v94
        let retSz
        let _v95
        _v95 := usr$Sub_sub$word(end, start)
        retSz := _v95
        return(start, retSz)
      }
      function usr$do_exec$unit_unit_t_increment126989 () {
        let _v96
        _v96 := usr$calldatasize()
        let _v97
        _v97 := usr$ge$word(_v96, 4)
        usr$require(_v97, false, 140739926, 911)
        let _v98
        _v98 := 4
        usr$invokable_invoke$t_increment126989()
        let _v99
        let _v100
        _v100 := usr$abi_encode$unit()
        _v99 := _v100
        let start
        let _v101
        _v101 := usr$Typedef_rep$memoryLtJ$bytes(_v99)
        start := _v101
        let end
        let _v102
        _v102 := usr$get_free_memory()
        end := _v102
        let retSz
        let _v103
        _v103 := usr$Sub_sub$word(end, start)
        retSz := _v103
        return(start, retSz)
      }
      function usr$eq (a, b) -> _result {
        let res
        res := eq(a, b)
        _result := res
        leave
      }
      function usr$eqWord (x, y) -> _v104 {
        let _v105
        _v105 := usr$eq(x, y)
        let _v106
        _v106 := usr$tobool(_v105)
        _v104 := _v106
        leave
      }
      function usr$fallback_default_implementation () {
        let _v107
        let _v108
        let _v109
        _v107 := false
        _v108 := 1227140848
        usr$revertWithError(false, 1227140848, 911)
      }
      function usr$ge$word (x, y) -> _v110 {
        let _v111
        _v111 := usr$le$word(y, x)
        _v110 := _v111
        leave
      }
      function usr$get_free_memory () -> _result {
        let _v112
        _v112 := usr$mload(64)
        _result := _v112
        leave
      }
      function usr$gtWord (x, y) -> _v113 {
        let _v114
        _v114 := usr$gt_(x, y)
        let _v115
        _v115 := usr$tobool(_v114)
        _v113 := _v115
        leave
      }
      function usr$gt_ (a, b) -> _result {
        let res
        res := gt(a, b)
        _result := res
        leave
      }
      function usr$increment () {
        let _v116
        _v116 := usr$RVA_acc$MemberAccessProxyLContractStorageLcxtJ_fieldSelector_loadType_offsetTypeJ$CounterCxt_Counter_number_sel_uint256_unit()
        let _v117
        _v117 := usr$Add_add$uint256(_v116, 1)
        usr$Assign_assign$a$storageLuint256J_uint256(0, _v117)
      }
      function usr$invokable_invoke$t_decrement130840 () {
        usr$decrement()
        leave
      }
      function usr$invokable_invoke$t_fallback_default_implementation74113 () {
        usr$fallback_default_implementation()
        leave
      }
      function usr$invokable_invoke$t_increment126989 () {
        usr$increment()
        leave
      }
      function usr$invokable_invoke$t_number123248 () -> _result {
        let _v118
        _v118 := usr$number()
        _result := _v118
        leave
      }
      function usr$invokable_invoke$t_setNumber119630 (arg119632) {
        let _v119
        _v119 := arg119632
        usr$setNumber(_v119)
        leave
      }
      function usr$le$word (x, y) -> _v120 {
        let _v121
        _v121 := usr$Ord_gt$word(x, y)
        let _v122
        _v122 := usr$not(_v121)
        _v120 := _v122
        leave
      }
      function usr$main () -> _v123 {
        usr$RunContract_exec$ContractLmethods_fbJ$pairLMethodLDispatchNameTy_Counter_number_NonPayable_unit_uint256_t_number123248J_pairLMethodLDispatchNameTy_Counter_setNumber_NonPayable_uint256_unit_t_setNumber119630J_pairLMethodLDispatchNameTy_Counter_increment_NonPayable_unit_unit_t_increment126989J_MethodLDispatchNameTy_Counter_decrement_NonPayable_unit_unit_t_decrement130840JJJJ_FallbackLNonPayable_unit_unit_t_fallback_default_implementation74113J()
      }
      function usr$mload (a) -> _result {
        let res
        res := mload(a)
        _result := res
        leave
      }
      function usr$mstore (a, b) { mstore(a, b) }
      function usr$not (_v124) -> _v125 {
        switch _v124
          case false {_v125 := true
                      leave}
          case true {_v125 := false
                     leave}
      }
      function usr$number () -> _result {
        let _v126
        _v126 := usr$RVA_acc$MemberAccessProxyLContractStorageLcxtJ_fieldSelector_loadType_offsetTypeJ$CounterCxt_Counter_number_sel_uint256_unit()
        _result := _v126
        leave
      }
      function usr$require (_v127, _v128, _v129, _v130) {
        let _v131
        let _v132
        _v132 := usr$not(_v127)
        _v131 := _v132
        switch _v131
          case false {}
          case true {usr$revertWithError(_v128, _v129, _v130)}
      }
      function usr$revertWithError (_v133, _v134, _v135) {
        switch _v133
          case false {usr$mstore(0, _v134)
                      usr$revert_(28, 4)}
          case true {switch _v134
                       case false {usr$revert_(0, 0)}
                       case true {let msg_
                                  let _v136
                                  _v136 := usr$Typedef_rep$memoryLtJ$string(_v135)
                                  msg_ := _v136
                                  let _v137
                                  _v137 := usr$Add_add$word(msg_, 32)
                                  let _v138
                                  _v138 := usr$mload(msg_)
                                  usr$revert_(_v137, _v138)}}
      }
      function usr$revert_ (a, b) { revert(a, b) }
      function usr$selector_matches$MethodLDispatchNameTy_Counter_decrement_NonPayable_unit_unit_t_decrement130840J () -> _v139 {
        let candidate
        candidate := 732876471
        let selector
        let _v140
        _v140 := usr$calldataload(0)
        let _v141
        _v141 := usr$shr(224, _v140)
        selector := _v141
        let _v142
        _v142 := usr$Eq_eq$word(selector, 732876471)
        _v139 := _v142
        leave
      }
      function usr$selector_matches$MethodLDispatchNameTy_Counter_increment_NonPayable_unit_unit_t_increment126989J () -> _v143 {
        let candidate
        candidate := 3500007562
        let selector
        let _v144
        _v144 := usr$calldataload(0)
        let _v145
        _v145 := usr$shr(224, _v144)
        selector := _v145
        let _v146
        _v146 := usr$Eq_eq$word(selector, 3500007562)
        _v143 := _v146
        leave
      }
      function usr$selector_matches$MethodLDispatchNameTy_Counter_number_NonPayable_unit_uint256_t_number123248J () -> _v147 {
        let candidate
        candidate := 2206332298
        let selector
        let _v148
        _v148 := usr$calldataload(0)
        let _v149
        _v149 := usr$shr(224, _v148)
        selector := _v149
        let _v150
        _v150 := usr$Eq_eq$word(selector, 2206332298)
        _v147 := _v150
        leave
      }
      function usr$selector_matches$MethodLDispatchNameTy_Counter_setNumber_NonPayable_uint256_unit_t_setNumber119630J () -> _v151 {
        let candidate
        candidate := 1068876235
        let selector
        let _v152
        _v152 := usr$calldataload(0)
        let _v153
        _v153 := usr$shr(224, _v152)
        selector := _v153
        let _v154
        _v154 := usr$Eq_eq$word(selector, 1068876235)
        _v151 := _v154
        leave
      }
      function usr$setNumber (newNumber) {
        usr$Assign_assign$a$storageLuint256J_uint256(0, newNumber)
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
      function usr$sstore (a, b) { sstore(a, b) }
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