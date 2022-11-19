;(function () {
  'use strict'
  var _0x46657b = {
      678: function (_0x2783f9, _0x4f4e18) {
        Object.defineProperty(_0x4f4e18, '__esModule', { value: true })
        _0x4f4e18.Hud =
          _0x4f4e18.Interface =
          _0x4f4e18.Utils =
          _0x4f4e18.Streaming =
          _0x4f4e18.Zones =
          _0x4f4e18.Procedures =
          _0x4f4e18.Events =
            void 0
        _0x4f4e18.Events = {
          on: (_0x4f239c, _0x188b24) => {
            return DPX.Events.on(_0x4f239c, _0x188b24)
          },
          onNet: (_0x1f2082, _0x561486) => {
            return DPX.Events.onNet(_0x1f2082, _0x561486)
          },
          emit: (_0x3c6294, ..._0x4b36be) => {
            return DPX.Events.emit(_0x3c6294, ..._0x4b36be)
          },
          emitNet: (_0x2a2b31, ..._0x222c54) => {
            return DPX.Events.emitNet(_0x2a2b31, ..._0x222c54)
          },
          remove: (_0x50be3a, _0x52b798) => {
            return DPX.Events.remove(_0x50be3a, _0x52b798)
          },
        }
        _0x4f4e18.Procedures = {
          register: (_0x5ded20, _0x28b3a3) => {
            return DPX.Procedures.register(_0x5ded20, _0x28b3a3)
          },
          execute: (_0x41a21f, ..._0x2e3772) => {
            return (
              console.log('execute', _0x41a21f, _0x2e3772),
              DPX.Procedures.execute(_0x41a21f, ..._0x2e3772)
            )
          },
        }
        _0x4f4e18.Zones = {
          isActive: (_0x4a4a63, _0x34bec2) => {
            return DPX.Zones.isActive(_0x4a4a63, _0x34bec2)
          },
          onEnter: (_0x494fad, _0x323903) => {
            return DPX.Zones.onEnter(_0x494fad, _0x323903)
          },
          onExit: (_0x541aec, _0x2ec5e1) => {
            return DPX.Zones.onExit(_0x541aec, _0x2ec5e1)
          },
          addBoxZone: (
            _0xd67b49,
            _0x5dc9a6,
            _0x3bbcbc,
            _0x263cde,
            _0x121ac8,
            _0x3d6ce7,
            _0x1eae1d = {}
          ) => {
            return DPX.Zones.addBoxZone(
              _0xd67b49,
              _0x5dc9a6,
              _0x3bbcbc,
              _0x263cde,
              _0x121ac8,
              _0x3d6ce7,
              _0x1eae1d
            )
          },
          addBoxTarget: (
            _0x3cbdd1,
            _0x323eaf,
            _0x575aee,
            _0xd03814,
            _0xb6ba1e,
            _0x1a8e31,
            _0x18a195 = {}
          ) => {
            return DPX.Zones.addBoxTarget(
              _0x3cbdd1,
              _0x323eaf,
              _0x575aee,
              _0xd03814,
              _0xb6ba1e,
              _0x1a8e31,
              _0x18a195
            )
          },
        }
        _0x4f4e18.Streaming = {
          loadModel: (_0x175d5f) => {
            return DPX.Streaming.loadModel(_0x175d5f)
          },
          loadTexture: (_0x558b6d) => {
            return DPX.Streaming.loadTexture(_0x558b6d)
          },
          loadAnim: (_0x4b3aed) => {
            return DPX.Streaming.loadAnim(_0x4b3aed)
          },
          loadClipSet: (_0x3ab1c5) => {
            return DPX.Streaming.loadClipSet(_0x3ab1c5)
          },
          loadWeaponAsset: (_0x4cf4c9, _0x279398, _0x59e8c0) => {
            return DPX.Streaming.loadWeaponAsset(_0x4cf4c9)
          },
          loadNamedPtfxAsset: (_0x43533b) => {
            return DPX.Streaming.loadNamedPtfxAsset(_0x43533b)
          },
        }
        _0x4f4e18.Utils = {
          cache: (_0x3897c1, _0x4da209) => {
            return DPX.Utils.cache(_0x3897c1, _0x4da209)
          },
          cacheableMap: (_0x230c78, _0x18cc83) => {
            return DPX.Utils.cacheableMap(_0x230c78, _0x18cc83)
          },
          waitForCondition: (_0x315e22, _0x28f3fe) => {
            return DPX.Utils.waitForCondition(_0x315e22, _0x28f3fe)
          },
          getMapRange: (_0xff253a, _0x3979bc, _0x4c0284) => {
            return DPX.Utils.getMapRange(_0xff253a, _0x3979bc, _0x4c0284)
          },
          getDistance: (
            [_0x1e608f, _0x162771, _0x497e1a],
            [_0x540f5e, _0x3cd531, _0x17b643]
          ) => {
            return DPX.Utils.getDistance(
              [_0x1e608f, _0x162771, _0x497e1a],
              [_0x540f5e, _0x3cd531, _0x17b643]
            )
          },
          getRandomNumber: (_0x55841f, _0x44bb75) => {
            return DPX.Utils.getRandomNumber(_0x55841f, _0x44bb75)
          },
        }
        _0x4f4e18.Interface = {
          addPeekEntryByModel: (_0x78e684, _0xc8ee38, _0x237162) => {
            return DPX.Interface.addPeekEntryByModel(
              _0x78e684,
              _0xc8ee38,
              _0x237162
            )
          },
          addPeekEntryByTarget: (_0x2eea22, _0x5e960d, _0x4ea8a0) => {
            return DPX.Interface.addPeekEntryByTarget(
              _0x2eea22,
              _0x5e960d,
              _0x4ea8a0
            )
          },
          addPeekEntryByFlag: (_0x28c072, _0x52b60d, _0x2274c2) => {
            return DPX.Interface.addPeekEntryByFlag(
              _0x28c072,
              _0x52b60d,
              _0x2274c2
            )
          },
          taskbar: (
            _0x25f34b,
            _0x44fcc6,
            _0x5a8f98 = false,
            _0x3c3787 = null
          ) => {
            return DPX.Interface.taskbar(
              _0x25f34b,
              _0x44fcc6,
              _0x5a8f98,
              _0x3c3787
            )
          },
          phoneConfirmation: (_0x318877, _0x108705, _0x43fe2c) => {
            return DPX.Interface.phoneConfirmation(
              _0x318877,
              _0x108705,
              _0x43fe2c
            )
          },
          phoneNotification: (
            _0x2ba57c,
            _0x4f62da,
            _0x2d2fa2,
            _0x3976df = true
          ) => {
            return DPX.Interface.phoneNotification(
              _0x2ba57c,
              _0x4f62da,
              _0x2d2fa2,
              _0x3976df
            )
          },
        }
        _0x4f4e18.Hud = {
          createBlip: (_0x4f96dd, ..._0x40abf5) => {
            return DPX.Hud.createBlip(_0x4f96dd, ..._0x40abf5)
          },
          applyBlipSettings: (
            _0x2cf4c7,
            _0x3f71e5,
            _0x68e810,
            _0x5b3cc5,
            _0x1128e1,
            _0xfd6b65,
            _0x526167,
            _0x40463b
          ) => {
            return DPX.Hud.applyBlipSettings(
              _0x2cf4c7,
              _0x3f71e5,
              _0x68e810,
              _0x5b3cc5,
              _0x1128e1,
              _0xfd6b65,
              _0x526167,
              _0x40463b
            )
          },
        }
      },
      615: function (_0x293865, _0xd0e178) {
        Object.defineProperty(_0xd0e178, '__esModule', { value: true })
        _0xd0e178.mathClass = _0xd0e178.loadAnimDict = _0xd0e178.Delay = void 0
        let _0x1d5a62 = (_0x31cc1f) =>
          new Promise((_0x292590) => setTimeout(_0x292590, _0x31cc1f))
        _0xd0e178.Delay = _0x1d5a62
        async function _0x3cf421(_0x10a763) {
          while (!HasAnimDictLoaded(_0x10a763)) {
            RequestAnimDict(_0x10a763)
            await (0, _0xd0e178.Delay)(5)
          }
        }
        _0xd0e178.loadAnimDict = _0x3cf421
        class _0x2651c0 {
          constructor(_0x2b87b9 = 0, _0x27f5f9 = 0, _0x5a3376 = 0) {
            this.x = _0x2b87b9
            this.y = _0x27f5f9
            this.z = _0x5a3376
          }
          ['setFromArray'](_0x23b335) {
            return (
              (this.x = _0x23b335[0]),
              (this.y = _0x23b335[1]),
              (this.z = _0x23b335[2]),
              this
            )
          }
          ['getArray']() {
            return [this.x, this.y, this.z]
          }
          ['add'](_0x5f40ff) {
            return (
              (this.x += _0x5f40ff.x),
              (this.y += _0x5f40ff.y),
              (this.z += _0x5f40ff.z),
              this
            )
          }
          ['addScalar'](_0x2e777e) {
            return (
              (this.x += _0x2e777e),
              (this.y += _0x2e777e),
              (this.z += _0x2e777e),
              this
            )
          }
          ['sub'](_0x4343e2) {
            return (
              (this.x -= _0x4343e2.x),
              (this.y -= _0x4343e2.y),
              (this.z -= _0x4343e2.z),
              this
            )
          }
          ['equals'](_0x36700a) {
            return (
              this.x === _0x36700a.x &&
              this.y === _0x36700a.y &&
              this.z === _0x36700a.z
            )
          }
          ['subScalar'](_0x3b9604) {
            return (
              (this.x -= _0x3b9604),
              (this.y -= _0x3b9604),
              (this.z -= _0x3b9604),
              this
            )
          }
          ['multiply'](_0x16c4ed) {
            return (
              (this.x *= _0x16c4ed.x),
              (this.y *= _0x16c4ed.y),
              (this.z *= _0x16c4ed.z),
              this
            )
          }
          ['multiplyScalar'](_0x546a9d) {
            return (
              (this.x *= _0x546a9d),
              (this.y *= _0x546a9d),
              (this.z *= _0x546a9d),
              this
            )
          }
          ['round']() {
            return (
              (this.x = Math.round(this.x)),
              (this.y = Math.round(this.y)),
              (this.z = Math.round(this.z)),
              this
            )
          }
          ['floor']() {
            return (
              (this.x = Math.floor(this.x)),
              (this.y = Math.floor(this.y)),
              (this.z = Math.floor(this.z)),
              this
            )
          }
          ['ceil']() {
            return (
              (this.x = Math.ceil(this.x)),
              (this.y = Math.ceil(this.y)),
              (this.z = Math.ceil(this.z)),
              this
            )
          }
          ['magnitude']() {
            return Math.sqrt(
              this.x * this.x + this.y * this.y + this.z * this.z
            )
          }
          ['normalize']() {
            let _0x53346c = this.magnitude
            if (isNaN(_0x53346c)) {
              _0x53346c = 0
            }
            return this.multiplyScalar(1 / _0x53346c)
          }
          ['forward']() {
            const _0x5e4c59 = _0x2651c0
              .fromObject(this)
              .multiplyScalar(Math.PI / 180)
            return new _0x2651c0(
              -Math.sin(_0x5e4c59.z) * Math.abs(Math.cos(_0x5e4c59.x)),
              Math.cos(_0x5e4c59.z) * Math.abs(Math.cos(_0x5e4c59.x)),
              Math.sin(_0x5e4c59.x)
            )
          }
          ['getDistance'](_0x354a27) {
            const [_0x319dc9, _0x327f35, _0x4db30c] = [
              this.x - _0x354a27.x,
              this.y - _0x354a27.y,
              this.z - _0x354a27.z,
            ]
            return Math.sqrt(
              _0x319dc9 * _0x319dc9 +
                _0x327f35 * _0x327f35 +
                _0x4db30c * _0x4db30c
            )
          }
          ['getDistanceFromArray'](_0x12865d) {
            const [_0x60b8, _0x29a21c, _0x39b7b7] = [
              this.x - _0x12865d[0],
              this.y - _0x12865d[1],
              this.z - _0x12865d[2],
            ]
            return Math.sqrt(
              _0x60b8 * _0x60b8 + _0x29a21c * _0x29a21c + _0x39b7b7 * _0x39b7b7
            )
          }
          static ['fromArray'](_0x5ad084) {
            return new _0x2651c0(_0x5ad084[0], _0x5ad084[1], _0x5ad084[2])
          }
          static ['fromObject'](_0x54700a) {
            return new _0x2651c0(_0x54700a.x, _0x54700a.y, _0x54700a.z)
          }
        }
        _0xd0e178.mathClass = _0x2651c0
      },
    },
    _0x995b3e = {}
  function _0x2df2bb(_0x23e68c) {
    var _0x320f1e = _0x995b3e[_0x23e68c]
    if (_0x320f1e !== undefined) {
      return _0x320f1e.exports
    }
    var _0x50b858 = (_0x995b3e[_0x23e68c] = { exports: {} })
    return (
      _0x46657b[_0x23e68c](_0x50b858, _0x50b858.exports, _0x2df2bb),
      _0x50b858.exports
    )
  }
  !(function () {
    _0x2df2bb.g = (function () {
      if (typeof globalThis === 'object') {
        return globalThis
      }
      try {
        return this || new Function('return this')()
      } catch (_0x1fbfb4) {
        if (typeof window === 'object') {
          return window
        }
      }
    })()
  })()
  var _0x38b2af = {}
  !(function () {
    var _0x43e553 = {},
      prepObj
    prepObj = { value: true }
    prepObj = void 0
    const _0x3ea73a = _0x2df2bb(678),
      _0x1bac61 = _0x2df2bb(615)
    let objectTable = [],
      newObjTable = []
    setImmediate(async () => {
      await (0, _0x1bac61.Delay)(5000)
      Number(objectTable.length) === 0 && emitNet('ev-objects:requestObjects')
    })
    onNet('ev-objects:loadObjects', async (pObjectData) => {
      console.log('[ev-objects] Load Objects')
      let objectTable = pObjectData
      Object.entries(objectTable).forEach(([k, v]) => {
        prepareObject(v)
      })
    })
    onNet('lol:objects:prepareNewObject', async (newObject) => {
      prepareObject(newObject)
    })
    on('ev-polyzone:enter', async (name, data) => {
      if (name !== 'object_zone') {
        return
      }
      let fountData = objectTable.findIndex(
        (pData) => pData.id.toString() === data.id.toString()
      )
      if (!objectTable[fountData]) {
        return
      }
      if (objectTable[fountData].obj) {
        return
      }
      console.log('[ev-objects] Entered zone, load objects in distance.')
      let pCoords = objectTable[fountData].coordinates
      objectTable[fountData].obj = await createAndLoadObject(
        objectTable[fountData].model,
        pCoords.x,
        pCoords.y,
        pCoords.z,
        pCoords.h
      )
      let findData = newObjTable.findIndex(
        (fountdata) => fountdata.id.toString() === data.id.toString()
      )
      newObjTable[findData] = {
        x: pCoords.x,
        y: pCoords.y,
        z: pCoords.z,
      }
    })
    on('ev-polyzone:exit', (name, data) => {
      if (name !== 'object_zone') {
        return
      }
      let findData = objectTable.findIndex(
        (fountData) => fountData.id.toString() === data.id.toString()
      )
      if (!objectTable[findData]) {
        return
      }
      if (!objectTable[findData].obj) {
        return
      }
      console.log('[ev-objects] Left zone, unload objects in distance.')
      DeleteObject(objectTable[findData].obj)
      objectTable[findData].obj = 0
      let filteredData = newObjTable.filter(
        (_0x4926c1) => Number(_0x4926c1.id) !== Number(data.id)
      )
      newObjTable = filteredData
    })
    onNet('ev-objects:clearObjects', (objectData) => {
      Object.entries(objectData).forEach(([k, v]) => {
        let findIndex = newObjTable.findIndex(
          (fountIndex) => fountIndex.id.toString() === v.toString()
        )
        if (newObjTable[findIndex]) {
          let filterData = newObjTable.filter(
            (filteredData) => Number(filteredData.id) !== Number(v)
          )
          newObjTable = filterData
        }
        let findData = objectTable.findIndex(
          (fountData) => fountData.id.toString() === v.toString()
        )
        if (objectTable[findData]) {
          objectTable[findData].obj &&
            DeleteObject(Number(objectTable[findData].obj))
          let filterIndex = objectTable.filter(
            (filteredIndex) => Number(filteredIndex.id) !== Number(v)
          )
          objectTable = filterIndex
        }
      })
    })
    onNet('ev-objects:updateObjects', (objectData) => {
      Object.entries(objectData).forEach(([k, v]) => {
        let findData = newObjTable.findIndex(
          (fountData) => fountData.id.toString() === v.toString()
        )
        if (newObjTable[findData]) {
          let filterData = newObjTable.filter(
            (filteredData) => Number(filteredData.id) !== Number(v)
          )
          newObjTable = filterData
        }
        let findInd = objectTable.findIndex(
          (fountInd) => fountInd.id.toString() === v.toString()
        )
        if (objectTable[findInd]) {
          objectTable[findInd].obj && DeleteObject(objectTable[findInd].obj)
          let filterObjTable = objectTable.filter(
            (filteredObjTable) => Number(filteredObjTable.id) !== Number(v)
          )
          objectTable = filterObjTable
        }
      }),
        prepareObject(objectData)
    })
    async function prepareObject(objectData) {
      console.log('[ev-objects] Adding object: ', objectData)
      let coords = {
        x: objectData.coordinates.x,
        y: objectData.coordinates.y,
        z: objectData.coordinates.z,
      }
      PolyZone.addCircleZone(
        'object_zone',
        {
          x: objectData.coordinates.x,
          y: objectData.coordinates.y,
          z: objectData.coordinates.z,
        },
        Math.max(75, 40),
        { data: { id: objectData.id } }
      )
      let pObject = undefined,
        entityCoords = GetEntityCoords(PlayerPedId(), false),
        dist = GetDistanceBetweenCoords(
          entityCoords[0],
          entityCoords[1],
          entityCoords[2],
          coords.x,
          coords.y,
          coords.z,
          true
        )
      if (Number(dist) < 25) {
        let heading = objectData.coordinates.h
        if (heading === undefined) {
          heading = 0
        }
        pObject = await createAndLoadObject(
          objectData.model,
          coords.x,
          coords.y,
          coords.z,
          heading
        )
        newObjTable.push({
          id: objectData.id,
          vector: coords,
        })
      }
      objectTable.push({
        id: objectData.id,
        model: objectData.model,
        coordinates: objectData.coordinates,
        metaData: objectData.metaData,
        obj: pObject,
      })
    }
    prepObj = prepareObject
    async function createAndLoadObject(
      pObject,
      coordsX,
      coordsY,
      coordsZ,
      coordsH
    ) {
      await _0x3ea73a.Streaming.loadModel(pObject)
      const pObjHash = GetHashKey(pObject)
      let createdEntity = CreateObjectNoOffset(
        pObjHash,
        coordsX,
        coordsY,
        coordsZ,
        false,
        false,
        false
      )
      if (!coordsH) {
        coordsH = 0
      }
      if (typeof coordsH === 'number') {
        SetEntityHeading(createdEntity, coordsH + 0)
      } else {
        SetEntityRotation(
          createdEntity,
          coordsH.x,
          coordsH.y,
          coordsH.z,
          2,
          true
        )
      }
      return FreezeEntityPosition(createdEntity, true), createdEntity
    }
    on('onResourceStop', (resName) => {
      if (resName !== 'ev-objects') {
        return
      }
      Object.entries(objectTable).forEach(([k, v]) => {
        if (v.obj) {
          DeleteObject(Number(v.obj))
        }
      })
    })
    function GetObjectByEntity(pEntity) {
      let pFountData = false
      return (
        Object.entries(objectTable).forEach(([k, v]) => {
          if (Number(v.obj) === Number(pEntity)) {
            let findInd = objectTable.findIndex(
              (fountInd) => Number(fountInd.id) === Number(v.id)
            )
            objectTable[findInd] && (pFountData = objectTable[findInd])
          }
        }),
        pFountData
      )
    }
    exports('GetObjectByEntity', GetObjectByEntity)
    function GetObject(pObject) {
      let pFountData = false,
        findInd = objectTable.findIndex(
          (fountInd) => fountInd.id.toString() === pObject.toString()
        )
      return (
        objectTable[findInd] && (pFountData = objectTable[findInd]), pFountData
      )
    }
    exports('GetObject', GetObject)
    function DelObject(obj) {
      let deleted = RPC.execute('ev-objects:DeleteObject', obj)
      return deleted
    }
    exports('DelObject', DelObject)
    function UpdateObject(object, updatedObject) {
      RPC.execute('ev-objects:UpdateObject', object, updatedObject)
    }
    exports('UpdateObject', UpdateObject)
    RegisterCommand(
      'getObject',
      (src, args, user) => {
        let obj = args[0],
          consoleObj = _0x14414e(obj)
        console.log('[ev-objects] getObject return: ', consoleObj)
      },
      false
    )
    RegisterCommand(
      'objects:print',
      () => {
        console.log(objectTable)
      },
      false
    )
  })()
  !(function () {
    var _0x2dcc1b = _0x38b2af,
      _0x3cb0b3
    _0x3cb0b3 = { value: true }
    const _0x54d89c = _0x2df2bb(615)
    let _0x4f06bd = undefined,
      _0x2acedf = undefined,
      _0x538309 = false,
      _0x573470 = 0,
      _0x304a5c = undefined,
      _0x1e299c = undefined
    const PlaceAndSaveObject = async (
      pObjectModel,
      pHeading = {},
      _0x72d15e,
      _0x46e724 = () => true,
      pRando = 'objects',
      pMetaData
    ) => {
      const [_0x5447e5, pCoords] = await _0x254698(
        pObjectModel,
        _0x72d15e,
        _0x46e724
      )
      if (!_0x5447e5) {
        return null
      }
      return await RPC.execute(
        'ev-objects:SaveObject',
        pRando,
        pObjectModel,
        pCoords.coords,
        pCoords.rotation,
        pHeading,
        pMetaData
      )
    }
    exports('PlaceAndSaveObject', PlaceAndSaveObject)
    let _0x49ebb8 = false
    const _0x254698 = async (_0x1debe8, _0x1e1814, _0x65c686 = () => true) => {
      var _0x3deadd, _0x3e8019, _0x54e9e9, _0x1e7782
      if (_0x49ebb8) {
        return [false, null]
      }
      const _0x3c5547 =
        typeof _0x1debe8 === 'string' ? _0x1debe8.trim() : _0x1debe8
      if (!IsModelValid(_0x3c5547)) {
        return [false, null]
      }
      _0x49ebb8 = true
      await _0x14b230(_0x3c5547)
      const [_0x320bb1, _0xb5f359] = GetModelDimensions(_0x3c5547),
        _0x3853c6 = _0x54d89c.mathClass.fromArray(_0x320bb1),
        _0x265e80 = _0x54d89c.mathClass.fromArray(_0xb5f359),
        _0x1039de = _0x265e80.sub(_0x3853c6),
        _0x30bb06 = PlayerPedId()
      let _0x2ead42 =
          (_0x3deadd = _0x1e1814.groundSnap) !== null && _0x3deadd !== void 0
            ? _0x3deadd
            : _0x1e1814.forceGroundSnap,
        _0x9db7cb = GetEntityHeading(_0x30bb06),
        _0x46bb15 = _0x1e1814.useModelOffset,
        _0x16f365 = true,
        _0x137066 = true,
        _0x544df1 = true,
        _0xe78988 =
          (_0x3e8019 = _0x1e1814.zOffset) !== null && _0x3e8019 !== void 0
            ? _0x3e8019
            : 0,
        _0x5e482a = false
      const _0x184686 =
          (_0x54e9e9 = _0x1e1814.alignToSurface) !== null &&
          _0x54e9e9 !== void 0
            ? _0x54e9e9
            : false,
        _0x10b75f =
          (_0x1e7782 = _0x1e1814.surfaceOffset) !== null && _0x1e7782 !== void 0
            ? _0x1e7782
            : 0,
        _0x3485b5 = CreateObjectNoOffset(
          _0x3c5547,
          0,
          0,
          0,
          false,
          false,
          false
        )
      SetEntityAlpha(_0x3485b5, 200, false)
      SetEntityCollision(_0x3485b5, false, false)
      SetCanClimbOnEntity(_0x3485b5, false)
      SetEntityDrawOutlineColor(255, 0, 0, 128)
      const _0x3366e4 = setTick(() => {
          var _0x2b0b7e
          const [
            _0x3810f3,
            _0x588679,
            _0x2c7d82,
            _0xd5cab8,
            _0x2cd1d1,
            _0x32b274,
          ] = _0x39cbec(
            19,
            _0x3485b5,
            (_0x2b0b7e = _0x1e1814.distance) !== null && _0x2b0b7e !== void 0
              ? _0x2b0b7e
              : 10
          )
          if (_0x588679) {
            const _0x2ecb12 = _0x54d89c.mathClass.fromArray(_0x2c7d82)
            !_0x2ead42 && _0x46bb15 && (_0x2ecb12.z += _0x1039de.z / 2)
            let _0x47ac2e = [0, 0, 0]
            _0x184686
              ? ((_0x9db7cb =
                  -Math.atan2(_0xd5cab8[0], _0xd5cab8[1]) * 57.2958 + 180),
                SetEntityHeading(_0x3485b5, _0x9db7cb),
                (_0x47ac2e = GetEntityForwardVector(_0x3485b5).map(
                  (_0xcff0c3) => _0xcff0c3 * _0x10b75f
                )))
              : SetEntityHeading(_0x3485b5, _0x9db7cb)
            SetEntityCoords(
              _0x3485b5,
              _0x2ecb12.x - _0x47ac2e[0],
              _0x2ecb12.y - _0x47ac2e[1],
              _0x2ecb12.z - _0x47ac2e[2],
              false,
              false,
              false,
              false
            )
            _0x2ead42 && PlaceObjectOnGroundProperly_2(_0x3485b5)
            if (_0xe78988 !== 0) {
              const _0x8162c1 = _0x54d89c.mathClass.fromArray(
                GetEntityCoords(_0x3485b5, false)
              )
              _0x2ecb12.z += _0xe78988
              SetEntityCoords(
                _0x3485b5,
                _0x8162c1.x,
                _0x8162c1.y,
                _0x8162c1.z + _0xe78988,
                false,
                false,
                false,
                false
              )
            }
            const _0x49a684 = _0x2ead42
                ? _0x54d89c.mathClass.fromArray(
                    GetEntityCoords(_0x3485b5, true)
                  )
                : _0x2ecb12,
              _0x16a58d = _0x1e1814.collision
                ? !_0x25eb10(
                    _0x3485b5,
                    _0x30bb06,
                    _0x1039de,
                    _0x49a684,
                    _0x1e1814.colZOffset
                  )
                : true
            _0x544df1 =
              _0x16a58d &&
              true &&
              _0x65c686(_0x49a684, _0x2cd1d1, _0x3485b5, _0x32b274)
            if (_0x544df1) {
              SetEntityDrawOutline(_0x3485b5, false)
            } else {
              SetEntityDrawOutline(_0x3485b5, true)
            }
          } else {
            _0x544df1 = false
          }
          _0x1e1814.afterRender &&
            _0x1e1814.afterRender(_0x3485b5, !!_0x588679, _0x544df1)
        }),
        _0x174e0d = setTick(() => {
          DisableControlAction(0, 44, true)
          DisableControlAction(0, 46, true)
          DisableControlAction(0, 140, true)
          DisableControlAction(0, 20, true)
          DisableControlAction(0, 16, true)
          DisableControlAction(0, 17, true)
          DisableControlAction(0, 36, true)
          const _0x113d5d = IsDisabledControlPressed(0, 36)
          if (IsDisabledControlPressed(2, 17)) {
            if (_0x5e482a) {
              _0xe78988 += _0x113d5d ? 0.1 : 0.5
            } else {
              _0x9db7cb += _0x113d5d ? 1 : 5
              if (!_0x113d5d) {
                _0x9db7cb = Math.round(_0x9db7cb)
              }
            }
          } else {
            if (IsDisabledControlPressed(2, 16)) {
              if (_0x5e482a) {
                _0xe78988 -= _0x113d5d ? 0.1 : 0.5
              } else {
                _0x9db7cb -= _0x113d5d ? 1 : 5
                if (!_0x113d5d) {
                  _0x9db7cb = Math.round(_0x9db7cb)
                }
              }
            }
          }
          if (_0x9db7cb > 360) {
            _0x9db7cb -= 360
          } else {
            _0x9db7cb < 0 && (_0x9db7cb += 360)
          }
          _0x1e1814.groundSnap &&
            !_0x1e1814.forceGroundSnap &&
            IsDisabledControlJustPressed(0, 44) &&
            (_0x2ead42 = !_0x2ead42)
          _0x1e1814.useModelOffset &&
            IsDisabledControlJustPressed(0, 140) &&
            (_0x46bb15 = !_0x46bb15)
          if (_0x1e1814.adjustZ && IsDisabledControlJustPressed(0, 20)) {
            _0x5e482a = !_0x5e482a
            SetEntityAlpha(_0x3485b5, _0x5e482a ? 255 : 200, false)
          }
          ;(IsDisabledControlJustPressed(0, 200) ||
            IsDisabledControlJustPressed(0, 177)) &&
            (_0x16f365 = false)
          if (_0x544df1 && IsDisabledControlJustPressed(0, 46)) {
            _0x137066 = false
            _0x16f365 = false
          }
        })
      while (_0x16f365) {
        await (0, _0x54d89c.Delay)(1)
      }
      clearTick(_0x3366e4)
      clearTick(_0x174e0d)
      const _0x24265a = _0x54d89c.mathClass.fromArray(
          GetEntityCoords(_0x3485b5, true)
        ),
        _0x389bbc = _0x54d89c.mathClass.fromArray(
          GetEntityRotation(_0x3485b5, 2)
        ),
        _0x4fd77b = GetEntityQuaternion(_0x3485b5)
      _0x1b7d24(_0x3485b5)
      _0x49ebb8 = false
      if (_0x137066) {
        return [false, null]
      }
      const _0xa47eb9 = {}
      return (
        (_0xa47eb9.coords = _0x24265a),
        (_0xa47eb9.rotation = _0x389bbc),
        (_0xa47eb9.quaternion = _0x4fd77b),
        [true, _0xa47eb9]
      )
    }
    exports('PlaceObject', _0x254698)
    function _0x25eb10(_0x5574d5, _0x3fb1d4, _0x38236a, _0x35feb8, _0x598e5e) {
      const _0x2e96b9 = _0x54d89c.mathClass.fromArray(
          GetEntityRotation(_0x5574d5, 2)
        ),
        _0x2dfde1 = _0x54d89c.mathClass
          .fromObject(_0x38236a)
          .multiplyScalar(0.75),
        _0x2b915a = StartShapeTestBox(
          _0x35feb8.x,
          _0x35feb8.y,
          _0x35feb8.z +
            (_0x598e5e !== null && _0x598e5e !== void 0 ? _0x598e5e : 0),
          _0x2dfde1.x,
          _0x2dfde1.y,
          _0x2dfde1.z,
          _0x2e96b9.x,
          _0x2e96b9.y,
          _0x2e96b9.z,
          2,
          83,
          _0x3fb1d4,
          4
        ),
        [_0x2a362f, _0x705c34] = GetShapeTestResultIncludingMaterial(_0x2b915a)
      return _0x705c34
    }
    const _0x39cbec = (_0x36924d, _0x2fd1b4, _0x5a38ab = 5) => {
        const _0xb7f809 = GetGameplayCamCoord(),
          [_0xa67fc1, , _0x291295] = GetGameplayCamRot(0).map(
            (_0x57f2d5) => (Math.PI / 180) * _0x57f2d5
          ),
          _0x1fea0d = Math.abs(Math.cos(_0xa67fc1)),
          _0x5909ba = [
            -Math.sin(_0x291295) * _0x1fea0d,
            Math.cos(_0x291295) * _0x1fea0d,
            Math.sin(_0xa67fc1),
          ],
          _0x1b61b8 = _0x5909ba.map(
            (_0x37f1b5, _0x240f83) => _0xb7f809[_0x240f83] + _0x37f1b5
          ),
          _0x301e4a = _0x54d89c.mathClass
            .fromArray(GetEntityCoords(PlayerPedId(), false))
            .getDistanceFromArray(GetGameplayCamCoord()),
          _0x4f1617 = _0x5909ba.map(
            (_0x3d2695, _0x39094c) =>
              _0xb7f809[_0x39094c] + _0x3d2695 * (_0x5a38ab + _0x301e4a)
          ),
          _0xb721b8 = StartShapeTestSweptSphere(
            _0x1b61b8[0],
            _0x1b61b8[1],
            _0x1b61b8[2],
            _0x4f1617[0],
            _0x4f1617[1],
            _0x4f1617[2],
            0.2,
            _0x36924d,
            _0x2fd1b4,
            7
          )
        return GetShapeTestResultIncludingMaterial(_0xb721b8)
      },
      _0x1b7d24 = (_0x10b6dd) => {
        DoesEntityExist(_0x10b6dd) && DeleteObject(_0x10b6dd)
      }
    async function _0x14b230(_0x18fdec) {
      if (IsModelValid(_0x18fdec)) {
        RequestModel(_0x18fdec)
        let _0x40b0a2 = false
        setTimeout(() => (_0x40b0a2 = true), 3000)
        while (!HasModelLoaded(_0x18fdec) && !_0x40b0a2) {
          await (0, _0x54d89c.Delay)(10)
        }
        return !_0x40b0a2
      }
      return false
    }
    function _0x46659e(_0x3e1435, _0x192a18) {
      if (_0x304a5c === undefined) {
        return _0x5fb2b7()
      }
      let _0x22d8c1 = {
          x: _0x3e1435[0],
          y: _0x3e1435[1],
          z: _0x3e1435[2],
        },
        _0x5a2393 = GetEntityCoords(PlayerPedId(), false),
        _0x2ed623 = GetDistanceBetweenCoords(
          _0x5a2393[0],
          _0x5a2393[1],
          _0x5a2393[2],
          _0x22d8c1.x,
          _0x22d8c1.y,
          _0x22d8c1.z,
          true
        )
      if (Number(_0x2ed623) > 50) {
        emit('DoLongHudText', 'You cannot place the object this far away', 2)
        return
      }
      _0x538309 = true
      _0x4cef94(_0x22d8c1)
    }
    function _0x4cef94(_0x381b0f) {
      emitNet(
        'ev-objects:prepareObject',
        _0x4f06bd,
        _0x381b0f.x,
        _0x381b0f.y,
        _0x381b0f.z,
        _0x573470,
        _0x2acedf
      )
      _0x5fb2b7()
    }
    function _0x5fb2b7() {
      _0x573470 = 0
      _0x4f06bd = undefined
      _0x304a5c = undefined
      _0x538309 = false
    }
    function _0x4ad98d(_0x79df0, _0x3028f9) {
      let _0x312855 = GetGameplayCamCoord(),
        _0x44c736 = GetGameplayCamRot(0),
        _0x44e02e = (Math.PI / 180) * _0x44c736[0],
        _0x391522 = (Math.PI / 180) * _0x44c736[2],
        _0xb47ce0 = Math.abs(Math.cos(_0x44e02e)),
        _0x1c09af = -Math.sin(_0x391522) * _0xb47ce0,
        _0x488b3d = Math.cos(_0x391522) * _0xb47ce0,
        _0x831fd3 = Math.sin(_0x44e02e),
        _0x3bba15 = {
          x: _0x1c09af,
          y: _0x488b3d,
          z: _0x831fd3,
        },
        _0x5c938d = StartShapeTestSweptSphere(
          _0x312855[0] + _0x3bba15.x,
          _0x312855[1] + _0x3bba15.y,
          _0x312855[2] + _0x3bba15.z,
          _0x312855[0] + _0x3bba15.x * 200,
          _0x312855[1] + _0x3bba15.y * 200,
          _0x312855[2] + _0x3bba15.z * 200,
          0.2,
          _0x79df0,
          _0x3028f9,
          7
        )
      return GetShapeTestResult(_0x5c938d)
    }
    function _0x264aed() {
      const [_0x141562, _0x5dbe5f, _0x4e1d48, _0x1112a4, _0x4c46e3] = _0x4ad98d(
        1,
        0
      )
      Number(_0x5dbe5f) === 1 && (_0x304a5c = _0x4e1d48)
    }
    on('onResourceStop', (_0x4c6c42) => {
      if (_0x4c6c42 !== 'ev-objects') {
        return
      }
      false && DeleteObject(0)
    })
  })()
})()
