const { runQuery } = require('../../../../../common/snowflake/test-utils');

test('HEXRING should work', async () => {
    const query = `
        SELECT @@SF_PREFIX@@h3.HEXRING('8928308280fffff', 0) as d0,
               @@SF_PREFIX@@h3.HEXRING('8928308280fffff', 1) as d1,
               @@SF_PREFIX@@h3.HEXRING('8928308280fffff', 2) as d2
    `;
    const rows = await runQuery(query);
    expect(rows.length).toEqual(1);
    expect(rows[0].D0.sort()).toEqual([
        '8928308280fffff'
    ].sort());
    expect(rows[0].D1.sort()).toEqual([
        '8928308280bffff',
        '89283082807ffff',
        '89283082877ffff',
        '89283082803ffff',
        '89283082873ffff',
        '8928308283bffff'
    ].sort());
    expect(rows[0].D2.sort()).toEqual([
        '89283082813ffff',
        '89283082817ffff',
        '8928308281bffff',
        '89283082863ffff',
        '89283082823ffff',
        '8928308287bffff',
        '89283082833ffff',
        '8928308282bffff',
        '89283082857ffff',
        '892830828abffff',
        '89283082847ffff',
        '89283082867ffff'
    ].sort());
});

test('HEXRING should fail if any invalid argument', async () => {
    let query = 'SELECT @@SF_PREFIX@@h3.HEXRING(NULL, NULL)';
    await expect(runQuery(query)).rejects.toThrow();

    query = 'SELECT @@SF_PREFIX@@h3.HEXRING("abc", 1)';
    await expect(runQuery(query)).rejects.toThrow();

    query = 'SELECT @@SF_PREFIX@@h3.HEXRING("ff283473fffffff", -1)';
    await expect(runQuery(query)).rejects.toThrow();
});