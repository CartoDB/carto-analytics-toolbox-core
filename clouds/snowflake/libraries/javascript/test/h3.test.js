const h3FromLonglatLib = require('../build/h3_fromlonglat');
const compactLib = require('../build/h3_compact');
const isValidLib = require('../build/h3_isvalid');
const hexRingLib = require('../build/h3_hexring');
const isPentagonLib = require('../build/h3_ispentagon');
const kringLib = require('../build/h3_kring');
const kringDistancesLib = require('../build/h3_kring_distances');
const h3PolyfillLib = require('../build/h3_polyfill');
const boundaryLib = require('../build/h3_boundary');
const toChildrenLib = require('../build/h3_tochildren');
const toParentLib = require('../build/h3_toparent');
const uncompactLib = require('../build/h3_uncompact');

test('h3 library defined', () => {
    expect(h3FromLonglatLib.geoToH3).toBeDefined();
    expect(compactLib.compact).toBeDefined();
    expect(isValidLib.h3IsValid).toBeDefined();
    expect(hexRingLib.hexRing).toBeDefined();
    expect(hexRingLib.h3IsValid).toBeDefined();
    expect(isPentagonLib.h3IsPentagon).toBeDefined();
    expect(kringLib.kRing).toBeDefined();
    expect(kringLib.h3IsValid).toBeDefined();
    expect(kringDistancesLib.kRingDistances).toBeDefined();
    expect(kringDistancesLib.h3IsValid).toBeDefined();
    expect(h3PolyfillLib.polyfill).toBeDefined();
    expect(boundaryLib.h3ToGeoBoundary).toBeDefined();
    expect(boundaryLib.h3IsValid).toBeDefined();
    expect(toChildrenLib.h3ToChildren).toBeDefined();
    expect(toChildrenLib.h3IsValid).toBeDefined();
    expect(toParentLib.h3ToParent).toBeDefined();
    expect(toParentLib.h3IsValid).toBeDefined();
    expect(uncompactLib.uncompact).toBeDefined();
});
