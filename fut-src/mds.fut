
def generated_function (input: []u64) : [16]u64 =
        -- u64 addition and sub are naturally wrapping around 
    let node_34 = input[0] + input[8]
    let node_38 = input[4] + input[12]
    let node_36 = input[2] + input[10]
    let node_40 = input[6] + input[14]
    let node_35 = input[1] + input[9]
    let node_39 = input[5] + input[13]
    let node_37 = input[3] + input[11]
    let node_41 = input[7] + input[15]

    let node_50 = node_34 + node_38
    let node_52 = node_36 + node_40
    let node_51 = node_35 + node_39
    let node_53 = node_37 + node_41

    let node_160 = input[0] - input[8]
    let node_161 = input[1] - input[9]
    let node_165 = input[5] - input[13]
    let node_163 = input[3] - input[11]
    let node_167 = input[7] - input[15]
    let node_162 = input[2] - input[10]
    let node_166 = input[6] - input[14]
    let node_164 = input[4] - input[12]


    let node_58 = node_50 + node_52
    let node_59 = node_51 + node_53
    let node_90 = node_34 - node_38
    let node_91 = node_35 - node_39
    let node_93 = node_37 - node_41
    let node_92 = node_36 - node_40

    let node_64 = (node_58 + node_59) * 524757
    let node_67 = (node_58 - node_59) * 52427
    let node_71 = node_50 - node_52
    let node_72 = node_51 - node_53

    let node_177 = node_161 + node_165
    let node_179 = node_163 + node_167
    let node_178 = node_162 + node_166
    let node_176 = node_160 + node_164
    let node_69 = node_64 + node_67
    let node_397 = (node_71 * 18446744073709525744) - (node_72 * 53918)

    let node_1857 = node_90 * 395512
    let node_99 = node_91 + node_93
    let node_1865 = node_91 * 18446744073709254400
    let node_1869 = node_93 * 179380
    let node_1873 = node_92 * 18446744073709509368
    let node_1879 = node_160 * 35608

    let node_185 = node_161 + node_163
    let node_1915 = node_161 * 18446744073709340312
    let node_1921 = node_163 * 18446744073709494992
    let node_1927 = node_162 * 18446744073709450808

    let node_228 = node_165 + node_167
    let node_1939 = node_165 * 18446744073709420056
    let node_1945 = node_167 * 18446744073709505128
    let node_1951 = node_166 * 216536
    let node_1957 = node_164 * 18446744073709515080

    let node_70 = node_64 - node_67
    let node_702 = (node_71 * 53918) + (node_72 * 18446744073709525744)
    let node_1961 = node_90 * 18446744073709254400
    let node_1963 = node_91 * 395512
    let node_1965 = node_92 * 179380
    let node_1967 = node_93 * 18446744073709509368
    let node_1970 = node_160 * 18446744073709340312
    let node_1973 = node_161 * 35608

    let node_1982 = node_162 * 18446744073709494992
    let node_1985 = node_163 * 18446744073709450808
    let node_1988 = node_166 * 18446744073709505128
    let node_1991 = node_167 * 216536
    let node_1994 = node_164 * 18446744073709420056
    let node_1997 = node_165 * 18446744073709515080
    let node_98 = node_90 + node_92
    let node_184 = node_160 + node_162
    let node_227 = node_164 + node_166
    let node_86 = node_69 + node_397
    let node_403 = node_1857 - ((node_99 * 18446744073709433780) - node_1865 - node_1869 + node_1873)

    let node_271 = node_177 + node_179
    let node_1891 = node_177 * 18446744073709208752
    let node_1897 = node_179 * 18446744073709448504
    let node_1903 = node_178 * 115728
    let node_1909 = node_185 * 18446744073709283688
    let node_1933 = node_228 * 18446744073709373568
    let node_88 = node_70 + node_702
    let node_708 = node_1961 + node_1963 - (node_1965 + node_1967)
    let node_1976 = node_178 * 18446744073709448504
    let node_1979 = node_179 * 115728
    let node_87 = node_69 - node_397

    let node_897 = node_1865 + (node_98 * 353264) - node_1857 - node_1873 - node_1869
    let node_2007 = node_184 * 18446744073709486416
    let node_2013 = node_227 * 180000
    let node_89 = node_70 - node_702
    let node_1077 = (node_98 * 18446744073709433780) + (node_99 * 353264) - (node_1961 + node_1963) - (node_1965 + node_1967)
    let node_2020 = node_184 * 18446744073709283688
    let node_2023 = node_185 * 18446744073709486416
    let node_2026 = node_227 * 18446744073709373568
    let node_2029 = node_228 * 180000
    let node_2035 = node_176 * 18446744073709550688
    let node_2038 = node_176 * 18446744073709208752
    let node_2041 = node_177 * 18446744073709550688

    let node_270 = node_176 + node_178
    let node_152 = node_86 + node_403
    let node_412 = node_1879 - ((node_271 * 18446744073709105640) - node_1891 - node_1897 + node_1903 - (node_1909 - node_1915 - node_1921 + node_1927) - (node_1933 - node_1939 - node_1945 + node_1951) + node_1957)
    let node_154 = node_88 + node_708
    let node_717 = node_1970 + node_1973 - (node_1976 + node_1979 - (node_1982 + node_1985) - (node_1988 + node_1991) + (node_1994 + node_1997))
    let node_156 = node_87 + node_897
    let node_906 = node_1915 + node_2007 - node_1879 - node_1927 - (node_1897 - node_1921 - node_1945 + (node_1939 + node_2013 - node_1957 - node_1951))
    let node_158 = node_89 + node_1077
    let node_1086 = node_2020 + node_2023 - (node_1970 + node_1973) - (node_1982 + node_1985) - (node_2026 + node_2029 - (node_1994 + node_1997) - (node_1988 + node_1991))
    let node_153 = node_86 - node_403
    let node_1237 = node_1909 - node_1915 - node_1921 + node_1927 + node_2035 - node_1879 - node_1957 - (node_1933 - node_1939 - node_1945 + node_1951)
    let node_155 = node_88 - node_708
    let node_1375 = node_1982 + node_1985 + (node_2038 + node_2041) - (node_1970 + node_1973) - (node_1994 + node_1997) - (node_1988 + node_1991)
    let node_157 = node_87 - node_897
    let node_1492 = node_1921 + (node_1891 + (node_270 * 114800) - node_2035 - node_1903) - (node_1915 + node_2007 - node_1879 - node_1927) - (node_1939 + node_2013 - node_1957 - node_1951) - node_1945
    let node_159 = node_89 - node_1077
    let node_1657 = node_270 * 18446744073709105640 + node_271 * 114800 - (node_2038 + node_2041) - (node_1976 + node_1979) - (node_2020 + node_2023 - (node_1970 + node_1973) - (node_1982 + node_1985)) - (node_2026 + node_2029 - (node_1994 + node_1997) - (node_1988 + node_1991))
    
    in [
        node_152 + node_412,
        node_154 + node_717,
        node_156 + node_906,
        node_158 + node_1086,
        node_153 + node_1237,
        node_155 + node_1375,
        node_157 + node_1492,
        node_159 + node_1657,
        node_152 - node_412,
        node_154 - node_717,
        node_156 - node_906,
        node_158 - node_1086,
        node_153 - node_1237,
        node_155 - node_1375,
        node_157 - node_1492,
        node_159 - node_1657,
    ]

-- ==
-- entry: test_generated_function
-- input  { [0u64, 1u64, 2u64, 3u64, 4u64, 5u64, 6u64, 7u64, 8u64, 9u64, 10u64, 11u64, 12u64, 13u64, 14u64, 15u64] }
-- output { [55525840u64, 63638304u64, 64674416u64, 64411840u64, 70899728u64, 68225376u64, 62832048u64, 68147456u64, 61964112u64, 63314848u64, 61125104u64, 59050560u64, 64369296u64, 57485024u64, 59020848u64, 62848640u64] }
entry test_generated_function (input: [16]u64) : [16]u64 =
    generated_function(input)
