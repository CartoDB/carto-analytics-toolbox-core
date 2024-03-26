const { runQuery } = require('../../../common/test-utils');

test('Returns NULL with invalid parameters', async () => {
    const query = `
        WITH ids AS
        (
            SELECT 1 AS id, NULL as hid UNION ALL
            SELECT 2 AS id, 'ff283473fffffff' as hid
        )
        SELECT
            id,
            H3_BOUNDARY(hid) as bounds
        FROM ids
        ORDER BY id ASC
    `;

    const rows = await runQuery(query);
    expect(rows.length).toEqual(2);
    expect(rows[0].BOUNDS).toEqual(null);
    expect(rows[1].BOUNDS).toEqual(null);
});

test('Returns the expected geography', async () => {
    const query = `
        WITH ids AS
        (
            SELECT 1 AS id, '85283473fffffff' as hid, ST_GEOGRAPHYFROMWKB('01030000000100000007000000D87A13AD907A5EC07B98FEC9BBA242408A0D97AA2E775EC0C5CC41764DAD4240839571711B7B5EC00EE74CE2D3B64240385DE93F6A825EC0715EC9C6C6B54240CD366B96C9855EC0536EAB0935AB42407BCFBCCBDC815EC0ECADA278B0A14240D87A13AD907A5EC07B98FEC9BBA24240') AS expected UNION ALL
            SELECT 2 AS id, '81623ffffffffff' as hid, ST_GEOGRAPHYFROMWKB('0103000000010000000B0000008060535F54F84B40E78983FA78822940970E1277CE964B400632499F0C982440A2F1D26C12A04B40E4A7268B742F2240F5C1B84805B04C401811888504771E40B644F18E62464D403A43155C56351D40EF720750C1514E409168BD2ABAA62140E1A4093360A84E4028BCBE2826A923401623B2D549404E407715DAE13F8B28409EA43F05C5DD4D405A418E3CC46E2A40048BDB910F8C4C4095465DE4EC612A408060535F54F84B40E78983FA78822940') AS expected UNION ALL

            SELECT 3 AS id, '870813269ffffff' as hid, ST_GEOGRAPHYFROMWKB('01030000000100000008000000191278215D6C2D40298161A391A34F4044B57E0EC56C2D40186BF8DF61A24F40EB87C83C0C782D40E3473FB6E9A14F40FF66EE61EC822D40955B2943A1A24F40FA2B4E02B9822D407ED34F2839A34F408434C15961812D40FA8C631AECA34F40282FBC8D3D772D407144893F49A44F40191278215D6C2D40298161A391A34F40') AS expected UNION ALL
            SELECT 4 AS id, '8708132c9ffffff' as hid, ST_GEOGRAPHYFROMWKB('01030000000100000008000000F751CF9FE8F52D40AB9F0C36C5964F40B4761B0D49F62D40453A748F94954F40211F43B688012E40A38A279E1A954F40FF974CD2680C2E405A14A246D1954F401D112132390C2E403DA9539D69964F4087B9A545E80A2E4099CBD70C1D974F400A3D0F06C9002E40B24AB5ED7B974F40F751CF9FE8F52D40AB9F0C36C5964F40') AS expected UNION ALL
            SELECT 5 AS id, '870811a69ffffff' as hid, ST_GEOGRAPHYFROMWKB('01030000000100000008000000AA7C1A2DFC9A2940E7E37A3B3BFA4F401D357D059A9B2940AA8259B611F94F40624FAA2913A729406941A210A6F84F409E366E73EFB12940A3E4A6E363F94F4081E26F20A1B12940E7FAFFA9F8F94F40BC665B6919B029404DD2BD13A8FA4F40265908A7D8A52940818F161EF9FA4F40AA7C1A2DFC9A2940E7E37A3B3BFA4F40') AS expected
        )
        SELECT
            *,
            H3_BOUNDARY(hid) as bounds
        FROM ids
    `;

    const rows = await runQuery(query);
    expect(rows.length).toEqual(5);
    expect(rows[0].EXPECTED).toEqual(rows[0].BOUNDS);
    expect(rows[1].EXPECTED).toEqual(rows[1].BOUNDS);
    expect(rows[2].EXPECTED).toEqual(rows[2].BOUNDS);
    expect(rows[3].EXPECTED).toEqual(rows[3].BOUNDS);
    expect(rows[4].EXPECTED).toEqual(rows[4].BOUNDS);
});