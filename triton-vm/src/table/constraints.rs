use ndarray::ArrayView1;
use twenty_first::prelude::BFieldElement;
use twenty_first::prelude::XFieldElement;
use crate::table::challenges::Challenges;
use crate::table::extension_table::Evaluable;
use crate::table::extension_table::Quotientable;
use crate::table::master_table::MasterExtTable;
impl Evaluable<BFieldElement> for MasterExtTable {
    #[allow(unused_variables)]
    fn evaluate_initial_constraints(
        base_row: ArrayView1<BFieldElement>,
        ext_row: ArrayView1<XFieldElement>,
        challenges: &Challenges,
    ) -> Vec<XFieldElement> {
        let node_468 = (BFieldElement::from_raw_u64(4294967295u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (base_row[129usize]));
        let node_474 = ((challenges[52usize]) * (base_row[131usize]))
            + ((challenges[53usize]) * (base_row[133usize]));
        let node_477 = ((challenges[52usize]) * (base_row[130usize]))
            + ((challenges[53usize]) * (base_row[132usize]));
        let base_constraints = [
            base_row[0usize],
            base_row[3usize],
            base_row[5usize],
            base_row[7usize],
            base_row[9usize],
            base_row[19usize],
            base_row[20usize],
            base_row[21usize],
            base_row[22usize],
            base_row[23usize],
            base_row[24usize],
            base_row[25usize],
            base_row[26usize],
            base_row[27usize],
            base_row[28usize],
            base_row[29usize],
            base_row[30usize],
            base_row[31usize],
            base_row[32usize],
            (base_row[38usize]) + (BFieldElement::from_raw_u64(18446744000695107601u64)),
            (base_row[48usize]) + (BFieldElement::from_raw_u64(18446744000695107601u64)),
            base_row[55usize],
            base_row[57usize],
            base_row[59usize],
            base_row[60usize],
            base_row[61usize],
            (base_row[62usize]) + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            base_row[64usize],
            base_row[136usize],
            (base_row[149usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((((base_row[12usize])
                        + (BFieldElement::from_raw_u64(18446744065119617026u64)))
                        * (base_row[13usize]))
                        * ((base_row[14usize])
                            + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                        * ((base_row[15usize])
                            + (BFieldElement::from_raw_u64(18446744065119617026u64))))),
            (base_row[150usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((base_row[149usize]) * (base_row[16usize]))
                        * ((base_row[17usize])
                            + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                        * ((base_row[18usize])
                            + (BFieldElement::from_raw_u64(18446744065119617026u64))))),
        ];
        let ext_constraints = [
            ext_row[0usize],
            ((ext_row[1usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (challenges[29usize])))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (base_row[1usize])),
            (ext_row[2usize]) + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((((((((((challenges[0usize]) + (base_row[33usize])) * (challenges[0usize]))
                + (base_row[34usize])) * (challenges[0usize])) + (base_row[35usize]))
                * (challenges[0usize])) + (base_row[36usize])) * (challenges[0usize]))
                + (base_row[37usize]))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (challenges[62usize])),
            (ext_row[3usize]) + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((ext_row[5usize])
                * ((challenges[3usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (((challenges[14usize]) * (base_row[10usize]))
                            + ((challenges[15usize]) * (base_row[11usize]))))))
                + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            (ext_row[4usize]) + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            (ext_row[6usize]) + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            (ext_row[7usize]) + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            (ext_row[8usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((challenges[9usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * ((challenges[25usize]) * (base_row[10usize]))))),
            ((ext_row[13usize]) * (challenges[11usize]))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (base_row[45usize])),
            (((base_row[10usize])
                + (BFieldElement::from_raw_u64(18446743992105173011u64)))
                * ((ext_row[9usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                + ((base_row[150usize])
                    * ((ext_row[9usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (challenges[4usize])))),
            (ext_row[10usize]) + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            (ext_row[11usize]) + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ext_row[12usize],
            (((ext_row[14usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((challenges[7usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((((challenges[16usize]) * (base_row[46usize]))
                                + ((challenges[17usize]) * (base_row[47usize])))
                                + ((challenges[18usize])
                                    * (BFieldElement::from_raw_u64(68719476720u64))))
                                + ((challenges[19usize]) * (base_row[49usize])))))))
                * ((base_row[47usize])
                    + (BFieldElement::from_raw_u64(18446744060824649731u64))))
                + (((ext_row[14usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64)))
                    * ((base_row[47usize])
                        * ((base_row[47usize])
                            + (BFieldElement::from_raw_u64(18446744065119617026u64))))),
            ext_row[15usize],
            ext_row[18usize],
            (ext_row[19usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (base_row[56usize])),
            ((ext_row[16usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (challenges[12usize]))) + (base_row[52usize]),
            (ext_row[17usize]) + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((((ext_row[20usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (challenges[8usize])))
                + (((((base_row[50usize]) * (challenges[20usize]))
                    + ((base_row[51usize]) * (challenges[23usize])))
                    + ((base_row[52usize]) * (challenges[21usize])))
                    + ((base_row[53usize]) * (challenges[22usize]))))
                * ((base_row[51usize])
                    + (BFieldElement::from_raw_u64(18446744060824649731u64))))
                + (((ext_row[20usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64)))
                    * (((base_row[51usize])
                        + (BFieldElement::from_raw_u64(18446744065119617026u64)))
                        * (base_row[51usize]))),
            ext_row[21usize],
            (ext_row[22usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((challenges[9usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * ((challenges[25usize]) * (base_row[58usize]))))),
            ext_row[23usize],
            (ext_row[25usize]) + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            (ext_row[26usize]) + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            (ext_row[27usize]) + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((ext_row[24usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (challenges[30usize])))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((((((((((((((((((challenges[29usize])
                        + ((((((base_row[65usize])
                            * (BFieldElement::from_raw_u64(18446744069414518785u64)))
                            + ((base_row[66usize])
                                * (BFieldElement::from_raw_u64(18446744069414584320u64))))
                            + ((base_row[67usize])
                                * (BFieldElement::from_raw_u64(281474976645120u64))))
                            + (base_row[68usize]))
                            * (BFieldElement::from_raw_u64(1u64))))
                        * (challenges[29usize]))
                        + ((((((base_row[69usize])
                            * (BFieldElement::from_raw_u64(18446744069414518785u64)))
                            + ((base_row[70usize])
                                * (BFieldElement::from_raw_u64(18446744069414584320u64))))
                            + ((base_row[71usize])
                                * (BFieldElement::from_raw_u64(281474976645120u64))))
                            + (base_row[72usize]))
                            * (BFieldElement::from_raw_u64(1u64))))
                        * (challenges[29usize]))
                        + ((((((base_row[73usize])
                            * (BFieldElement::from_raw_u64(18446744069414518785u64)))
                            + ((base_row[74usize])
                                * (BFieldElement::from_raw_u64(18446744069414584320u64))))
                            + ((base_row[75usize])
                                * (BFieldElement::from_raw_u64(281474976645120u64))))
                            + (base_row[76usize]))
                            * (BFieldElement::from_raw_u64(1u64))))
                        * (challenges[29usize]))
                        + ((((((base_row[77usize])
                            * (BFieldElement::from_raw_u64(18446744069414518785u64)))
                            + ((base_row[78usize])
                                * (BFieldElement::from_raw_u64(18446744069414584320u64))))
                            + ((base_row[79usize])
                                * (BFieldElement::from_raw_u64(281474976645120u64))))
                            + (base_row[80usize]))
                            * (BFieldElement::from_raw_u64(1u64))))
                        * (challenges[29usize])) + (base_row[97usize]))
                        * (challenges[29usize])) + (base_row[98usize]))
                        * (challenges[29usize])) + (base_row[99usize]))
                        * (challenges[29usize])) + (base_row[100usize]))
                        * (challenges[29usize])) + (base_row[101usize]))
                        * (challenges[29usize])) + (base_row[102usize]))),
            ((ext_row[28usize])
                * ((challenges[48usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (((challenges[49usize]) * (base_row[65usize]))
                            + ((challenges[50usize]) * (base_row[81usize]))))))
                + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((ext_row[29usize])
                * ((challenges[48usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (((challenges[49usize]) * (base_row[66usize]))
                            + ((challenges[50usize]) * (base_row[82usize]))))))
                + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((ext_row[30usize])
                * ((challenges[48usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (((challenges[49usize]) * (base_row[67usize]))
                            + ((challenges[50usize]) * (base_row[83usize]))))))
                + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((ext_row[31usize])
                * ((challenges[48usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (((challenges[49usize]) * (base_row[68usize]))
                            + ((challenges[50usize]) * (base_row[84usize]))))))
                + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((ext_row[32usize])
                * ((challenges[48usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (((challenges[49usize]) * (base_row[69usize]))
                            + ((challenges[50usize]) * (base_row[85usize]))))))
                + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((ext_row[33usize])
                * ((challenges[48usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (((challenges[49usize]) * (base_row[70usize]))
                            + ((challenges[50usize]) * (base_row[86usize]))))))
                + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((ext_row[34usize])
                * ((challenges[48usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (((challenges[49usize]) * (base_row[71usize]))
                            + ((challenges[50usize]) * (base_row[87usize]))))))
                + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((ext_row[35usize])
                * ((challenges[48usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (((challenges[49usize]) * (base_row[72usize]))
                            + ((challenges[50usize]) * (base_row[88usize]))))))
                + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((ext_row[36usize])
                * ((challenges[48usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (((challenges[49usize]) * (base_row[73usize]))
                            + ((challenges[50usize]) * (base_row[89usize]))))))
                + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((ext_row[37usize])
                * ((challenges[48usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (((challenges[49usize]) * (base_row[74usize]))
                            + ((challenges[50usize]) * (base_row[90usize]))))))
                + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((ext_row[38usize])
                * ((challenges[48usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (((challenges[49usize]) * (base_row[75usize]))
                            + ((challenges[50usize]) * (base_row[91usize]))))))
                + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((ext_row[39usize])
                * ((challenges[48usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (((challenges[49usize]) * (base_row[76usize]))
                            + ((challenges[50usize]) * (base_row[92usize]))))))
                + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((ext_row[40usize])
                * ((challenges[48usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (((challenges[49usize]) * (base_row[77usize]))
                            + ((challenges[50usize]) * (base_row[93usize]))))))
                + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((ext_row[41usize])
                * ((challenges[48usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (((challenges[49usize]) * (base_row[78usize]))
                            + ((challenges[50usize]) * (base_row[94usize]))))))
                + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((ext_row[42usize])
                * ((challenges[48usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (((challenges[49usize]) * (base_row[79usize]))
                            + ((challenges[50usize]) * (base_row[95usize]))))))
                + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((ext_row[43usize])
                * ((challenges[48usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (((challenges[49usize]) * (base_row[80usize]))
                            + ((challenges[50usize]) * (base_row[96usize]))))))
                + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((node_468)
                * (((ext_row[44usize])
                    * ((challenges[48usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((challenges[49usize])
                                * (((BFieldElement::from_raw_u64(1099511627520u64))
                                    * (base_row[130usize])) + (base_row[131usize])))
                                + ((challenges[50usize])
                                    * (((BFieldElement::from_raw_u64(1099511627520u64))
                                        * (base_row[132usize])) + (base_row[133usize])))))))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (base_row[134usize]))))
                + ((base_row[129usize]) * (ext_row[44usize])),
            ((node_468)
                * ((((((ext_row[45usize])
                    * ((challenges[51usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (node_474))))
                    * ((challenges[51usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (node_477))))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((BFieldElement::from_raw_u64(8589934590u64))
                            * (challenges[51usize])))) + (node_474)) + (node_477)))
                + ((base_row[129usize]) * (ext_row[45usize])),
            ((ext_row[46usize])
                * ((challenges[51usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((base_row[137usize]) * (challenges[53usize])))))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (base_row[138usize])),
            ((ext_row[47usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (challenges[54usize])))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (base_row[137usize])),
            (((base_row[139usize])
                + (BFieldElement::from_raw_u64(18446744065119617026u64)))
                * (ext_row[48usize]))
                + ((base_row[139usize])
                    * (((ext_row[48usize])
                        * ((challenges[10usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((((challenges[55usize]) * (base_row[143usize]))
                                    + ((challenges[56usize]) * (base_row[145usize])))
                                    + ((challenges[57usize]) * (base_row[142usize])))
                                    + ((challenges[58usize]) * (base_row[147usize]))))))
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (base_row[148usize])))),
        ];
        base_constraints
            .into_iter()
            .map(|bfe| bfe.lift())
            .chain(ext_constraints)
            .collect()
    }
    #[allow(unused_variables)]
    fn evaluate_consistency_constraints(
        base_row: ArrayView1<BFieldElement>,
        ext_row: ArrayView1<XFieldElement>,
        challenges: &Challenges,
    ) -> Vec<XFieldElement> {
        let node_102 = (base_row[152usize])
            * ((base_row[64usize])
                + (BFieldElement::from_raw_u64(18446744047939747846u64)));
        let node_221 = (base_row[153usize])
            * ((base_row[64usize])
                + (BFieldElement::from_raw_u64(18446744047939747846u64)));
        let node_238 = ((base_row[154usize])
            * ((base_row[64usize])
                + (BFieldElement::from_raw_u64(18446744052234715141u64))))
            * ((base_row[64usize])
                + (BFieldElement::from_raw_u64(18446744047939747846u64)));
        let node_245 = ((base_row[154usize])
            * ((base_row[64usize])
                + (BFieldElement::from_raw_u64(18446744056529682436u64))))
            * ((base_row[64usize])
                + (BFieldElement::from_raw_u64(18446744047939747846u64)));
        let node_655 = (BFieldElement::from_raw_u64(4294967295u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (base_row[157usize]));
        let node_114 = (((base_row[63usize])
            + (BFieldElement::from_raw_u64(18446743992105173011u64)))
            * ((base_row[63usize])
                + (BFieldElement::from_raw_u64(18446743923385696291u64))))
            * ((base_row[63usize])
                + (BFieldElement::from_raw_u64(18446743828896415801u64)));
        let node_116 = (node_102) * (base_row[161usize]);
        let node_660 = (BFieldElement::from_raw_u64(4294967295u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (base_row[160usize]));
        let node_101 = (base_row[64usize])
            + (BFieldElement::from_raw_u64(18446744047939747846u64));
        let node_678 = (base_row[142usize])
            + (BFieldElement::from_raw_u64(18446743949155500061u64));
        let node_674 = (base_row[142usize])
            + (BFieldElement::from_raw_u64(18446743940565565471u64));
        let node_94 = (base_row[64usize])
            + (BFieldElement::from_raw_u64(18446744056529682436u64));
        let node_97 = (base_row[64usize])
            + (BFieldElement::from_raw_u64(18446744052234715141u64));
        let node_153 = ((((BFieldElement::from_raw_u64(18446744065119617025u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((base_row[65usize])
                    * (BFieldElement::from_raw_u64(281474976645120u64)))))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (base_row[66usize]))) * (base_row[109usize]))
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_155 = ((((BFieldElement::from_raw_u64(18446744065119617025u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((base_row[69usize])
                    * (BFieldElement::from_raw_u64(281474976645120u64)))))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (base_row[70usize]))) * (base_row[110usize]))
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_157 = ((((BFieldElement::from_raw_u64(18446744065119617025u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((base_row[73usize])
                    * (BFieldElement::from_raw_u64(281474976645120u64)))))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (base_row[74usize]))) * (base_row[111usize]))
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_159 = ((((BFieldElement::from_raw_u64(18446744065119617025u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((base_row[77usize])
                    * (BFieldElement::from_raw_u64(281474976645120u64)))))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (base_row[78usize]))) * (base_row[112usize]))
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_680 = (base_row[139usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_90 = (base_row[64usize])
            + (BFieldElement::from_raw_u64(18446744060824649731u64));
        let node_670 = (base_row[142usize])
            + (BFieldElement::from_raw_u64(18446744017874976781u64));
        let node_11 = (BFieldElement::from_raw_u64(4294967295u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (((BFieldElement::from_raw_u64(38654705655u64))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (base_row[3usize]))) * (base_row[4usize])));
        let node_8 = (BFieldElement::from_raw_u64(38654705655u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (base_row[3usize]));
        let node_104 = (((base_row[62usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64)))
            * ((base_row[62usize])
                + (BFieldElement::from_raw_u64(18446744060824649731u64))))
            * ((base_row[62usize])
                + (BFieldElement::from_raw_u64(18446744056529682436u64)));
        let node_85 = (base_row[62usize])
            + (BFieldElement::from_raw_u64(18446744060824649731u64));
        let node_73 = (base_row[63usize])
            + (BFieldElement::from_raw_u64(18446743992105173011u64));
        let node_79 = (base_row[63usize])
            + (BFieldElement::from_raw_u64(18446743923385696291u64));
        let node_82 = (base_row[63usize])
            + (BFieldElement::from_raw_u64(18446743828896415801u64));
        let node_126 = ((BFieldElement::from_raw_u64(18446744065119617025u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((base_row[65usize])
                    * (BFieldElement::from_raw_u64(281474976645120u64)))))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (base_row[66usize]));
        let node_133 = ((BFieldElement::from_raw_u64(18446744065119617025u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((base_row[69usize])
                    * (BFieldElement::from_raw_u64(281474976645120u64)))))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (base_row[70usize]));
        let node_140 = ((BFieldElement::from_raw_u64(18446744065119617025u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((base_row[73usize])
                    * (BFieldElement::from_raw_u64(281474976645120u64)))))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (base_row[74usize]));
        let node_147 = ((BFieldElement::from_raw_u64(18446744065119617025u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((base_row[77usize])
                    * (BFieldElement::from_raw_u64(281474976645120u64)))))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (base_row[78usize]));
        let node_89 = (base_row[64usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_663 = (base_row[142usize])
            + (BFieldElement::from_raw_u64(18446744052234715141u64));
        let node_666 = (base_row[142usize])
            + (BFieldElement::from_raw_u64(18446744009285042191u64));
        let node_86 = ((base_row[62usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64))) * (node_85);
        let node_83 = (base_row[62usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_103 = (base_row[62usize])
            + (BFieldElement::from_raw_u64(18446744056529682436u64));
        let base_constraints = [
            (node_11) * (base_row[4usize]),
            (node_11) * (node_8),
            (base_row[5usize])
                * ((base_row[5usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))),
            (base_row[6usize])
                * ((base_row[6usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))),
            (base_row[12usize])
                * ((base_row[12usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))),
            (base_row[13usize])
                * ((base_row[13usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))),
            (base_row[14usize])
                * ((base_row[14usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))),
            (base_row[15usize])
                * ((base_row[15usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))),
            (base_row[16usize])
                * ((base_row[16usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))),
            (base_row[17usize])
                * ((base_row[17usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))),
            (base_row[18usize])
                * ((base_row[18usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))),
            (base_row[8usize])
                * ((base_row[8usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))),
            (base_row[10usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((((((base_row[12usize])
                        + ((BFieldElement::from_raw_u64(8589934590u64))
                            * (base_row[13usize])))
                        + ((BFieldElement::from_raw_u64(17179869180u64))
                            * (base_row[14usize])))
                        + ((BFieldElement::from_raw_u64(34359738360u64))
                            * (base_row[15usize])))
                        + ((BFieldElement::from_raw_u64(68719476720u64))
                            * (base_row[16usize])))
                        + ((BFieldElement::from_raw_u64(137438953440u64))
                            * (base_row[17usize])))
                        + ((BFieldElement::from_raw_u64(274877906880u64))
                            * (base_row[18usize])))),
            ((base_row[8usize])
                * ((base_row[7usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                * (base_row[45usize]),
            (node_104) * (base_row[62usize]),
            (node_85) * (node_73),
            ((base_row[165usize]) * (node_79)) * (node_82),
            (node_104) * (base_row[64usize]),
            (node_114) * (base_row[64usize]),
            (node_153) * (base_row[109usize]),
            (node_155) * (base_row[110usize]),
            (node_157) * (base_row[111usize]),
            (node_159) * (base_row[112usize]),
            (node_153) * (node_126),
            (node_155) * (node_133),
            (node_157) * (node_140),
            (node_159) * (node_147),
            (node_153)
                * (((base_row[67usize])
                    * (BFieldElement::from_raw_u64(281474976645120u64)))
                    + (base_row[68usize])),
            (node_155)
                * (((base_row[71usize])
                    * (BFieldElement::from_raw_u64(281474976645120u64)))
                    + (base_row[72usize])),
            (node_157)
                * (((base_row[75usize])
                    * (BFieldElement::from_raw_u64(281474976645120u64)))
                    + (base_row[76usize])),
            (node_159)
                * (((base_row[79usize])
                    * (BFieldElement::from_raw_u64(281474976645120u64)))
                    + (base_row[80usize])),
            (node_114) * (base_row[103usize]),
            (node_114) * (base_row[104usize]),
            (node_114) * (base_row[105usize]),
            (node_114) * (base_row[106usize]),
            (node_114) * (base_row[107usize]),
            (node_114) * (base_row[108usize]),
            (node_116)
                * ((base_row[103usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))),
            (node_116)
                * ((base_row[104usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))),
            (node_116)
                * ((base_row[105usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))),
            (node_116)
                * ((base_row[106usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))),
            (node_116)
                * ((base_row[107usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))),
            (node_116)
                * ((base_row[108usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))),
            (((((node_102)
                * ((base_row[113usize])
                    + (BFieldElement::from_raw_u64(11408918724931329738u64))))
                + ((node_221)
                    * ((base_row[113usize])
                        + (BFieldElement::from_raw_u64(16073625066478178581u64)))))
                + ((base_row[155usize])
                    * ((base_row[113usize])
                        + (BFieldElement::from_raw_u64(12231462398569191607u64)))))
                + ((node_238)
                    * ((base_row[113usize])
                        + (BFieldElement::from_raw_u64(9408518518620565480u64)))))
                + ((node_245)
                    * ((base_row[113usize])
                        + (BFieldElement::from_raw_u64(11492978409391175103u64)))),
            (((((node_102)
                * ((base_row[114usize])
                    + (BFieldElement::from_raw_u64(2786462832312611053u64))))
                + ((node_221)
                    * ((base_row[114usize])
                        + (BFieldElement::from_raw_u64(11837051899140380443u64)))))
                + ((base_row[155usize])
                    * ((base_row[114usize])
                        + (BFieldElement::from_raw_u64(11546487907579866869u64)))))
                + ((node_238)
                    * ((base_row[114usize])
                        + (BFieldElement::from_raw_u64(1785884128667671832u64)))))
                + ((node_245)
                    * ((base_row[114usize])
                        + (BFieldElement::from_raw_u64(17615222217495663839u64)))),
            (((((node_102)
                * ((base_row[115usize])
                    + (BFieldElement::from_raw_u64(6782977121958050999u64))))
                + ((node_221)
                    * ((base_row[115usize])
                        + (BFieldElement::from_raw_u64(15625104599191418968u64)))))
                + ((base_row[155usize])
                    * ((base_row[115usize])
                        + (BFieldElement::from_raw_u64(14006427992450931468u64)))))
                + ((node_238)
                    * ((base_row[115usize])
                        + (BFieldElement::from_raw_u64(1188899344229954938u64)))))
                + ((node_245)
                    * ((base_row[115usize])
                        + (BFieldElement::from_raw_u64(5864349944556149748u64)))),
            (((((node_102)
                * ((base_row[116usize])
                    + (BFieldElement::from_raw_u64(8688421733879975670u64))))
                + ((node_221)
                    * ((base_row[116usize])
                        + (BFieldElement::from_raw_u64(12819157612210448391u64)))))
                + ((base_row[155usize])
                    * ((base_row[116usize])
                        + (BFieldElement::from_raw_u64(11770003398407723041u64)))))
                + ((node_238)
                    * ((base_row[116usize])
                        + (BFieldElement::from_raw_u64(14740727267735052728u64)))))
                + ((node_245)
                    * ((base_row[116usize])
                        + (BFieldElement::from_raw_u64(2745609811140253793u64)))),
            (((((node_102)
                * ((base_row[117usize])
                    + (BFieldElement::from_raw_u64(8602724563769480463u64))))
                + ((node_221)
                    * ((base_row[117usize])
                        + (BFieldElement::from_raw_u64(6235256903503367222u64)))))
                + ((base_row[155usize])
                    * ((base_row[117usize])
                        + (BFieldElement::from_raw_u64(15124190001489436038u64)))))
                + ((node_238)
                    * ((base_row[117usize])
                        + (BFieldElement::from_raw_u64(880257844992994007u64)))))
                + ((node_245)
                    * ((base_row[117usize])
                        + (BFieldElement::from_raw_u64(15189664869386394185u64)))),
            (((((node_102)
                * ((base_row[118usize])
                    + (BFieldElement::from_raw_u64(13589155570211330507u64))))
                + ((node_221)
                    * ((base_row[118usize])
                        + (BFieldElement::from_raw_u64(11242082964257948320u64)))))
                + ((base_row[155usize])
                    * ((base_row[118usize])
                        + (BFieldElement::from_raw_u64(14834674155811570980u64)))))
                + ((node_238)
                    * ((base_row[118usize])
                        + (BFieldElement::from_raw_u64(10737952517017171197u64)))))
                + ((node_245)
                    * ((base_row[118usize])
                        + (BFieldElement::from_raw_u64(5192963426821415349u64)))),
            (((((node_102)
                * ((base_row[119usize])
                    + (BFieldElement::from_raw_u64(10263462378312899510u64))))
                + ((node_221)
                    * ((base_row[119usize])
                        + (BFieldElement::from_raw_u64(5820425254787221108u64)))))
                + ((base_row[155usize])
                    * ((base_row[119usize])
                        + (BFieldElement::from_raw_u64(13004675752386552573u64)))))
                + ((node_238)
                    * ((base_row[119usize])
                        + (BFieldElement::from_raw_u64(15757222735741919824u64)))))
                + ((node_245)
                    * ((base_row[119usize])
                        + (BFieldElement::from_raw_u64(11971160388083607515u64)))),
            (((((node_102)
                * ((base_row[120usize])
                    + (BFieldElement::from_raw_u64(3264875873073042616u64))))
                + ((node_221)
                    * ((base_row[120usize])
                        + (BFieldElement::from_raw_u64(12019227591549292608u64)))))
                + ((base_row[155usize])
                    * ((base_row[120usize])
                        + (BFieldElement::from_raw_u64(1475232519215872482u64)))))
                + ((node_238)
                    * ((base_row[120usize])
                        + (BFieldElement::from_raw_u64(14382578632612566479u64)))))
                + ((node_245)
                    * ((base_row[120usize])
                        + (BFieldElement::from_raw_u64(11608544217838050708u64)))),
            (((((node_102)
                * ((base_row[121usize])
                    + (BFieldElement::from_raw_u64(3133435276616064683u64))))
                + ((node_221)
                    * ((base_row[121usize])
                        + (BFieldElement::from_raw_u64(4625353063880731092u64)))))
                + ((base_row[155usize])
                    * ((base_row[121usize])
                        + (BFieldElement::from_raw_u64(4883869161905122316u64)))))
                + ((node_238)
                    * ((base_row[121usize])
                        + (BFieldElement::from_raw_u64(3305272539067787726u64)))))
                + ((node_245)
                    * ((base_row[121usize])
                        + (BFieldElement::from_raw_u64(674972795234232729u64)))),
            (((((node_102)
                * ((base_row[122usize])
                    + (BFieldElement::from_raw_u64(13508500531157332153u64))))
                + ((node_221)
                    * ((base_row[122usize])
                        + (BFieldElement::from_raw_u64(3723900760706330287u64)))))
                + ((base_row[155usize])
                    * ((base_row[122usize])
                        + (BFieldElement::from_raw_u64(12579737103870920763u64)))))
                + ((node_238)
                    * ((base_row[122usize])
                        + (BFieldElement::from_raw_u64(17082569335437832789u64)))))
                + ((node_245)
                    * ((base_row[122usize])
                        + (BFieldElement::from_raw_u64(14165256104883557753u64)))),
            (((((node_102)
                * ((base_row[123usize])
                    + (BFieldElement::from_raw_u64(6968886508437513677u64))))
                + ((node_221)
                    * ((base_row[123usize])
                        + (BFieldElement::from_raw_u64(615596267195055952u64)))))
                + ((base_row[155usize])
                    * ((base_row[123usize])
                        + (BFieldElement::from_raw_u64(10119826060478909841u64)))))
                + ((node_238)
                    * ((base_row[123usize])
                        + (BFieldElement::from_raw_u64(229051680548583225u64)))))
                + ((node_245)
                    * ((base_row[123usize])
                        + (BFieldElement::from_raw_u64(15283356519694111298u64)))),
            (((((node_102)
                * ((base_row[124usize])
                    + (BFieldElement::from_raw_u64(9713264609690967820u64))))
                + ((node_221)
                    * ((base_row[124usize])
                        + (BFieldElement::from_raw_u64(18227830850447556704u64)))))
                + ((base_row[155usize])
                    * ((base_row[124usize])
                        + (BFieldElement::from_raw_u64(1528714547662620921u64)))))
                + ((node_238)
                    * ((base_row[124usize])
                        + (BFieldElement::from_raw_u64(2943254981416254648u64)))))
                + ((node_245)
                    * ((base_row[124usize])
                        + (BFieldElement::from_raw_u64(2306049938060341466u64)))),
            (((((node_102)
                * ((base_row[125usize])
                    + (BFieldElement::from_raw_u64(12482374976099749513u64))))
                + ((node_221)
                    * ((base_row[125usize])
                        + (BFieldElement::from_raw_u64(15609691041895848348u64)))))
                + ((base_row[155usize])
                    * ((base_row[125usize])
                        + (BFieldElement::from_raw_u64(12972275929555275935u64)))))
                + ((node_238)
                    * ((base_row[125usize])
                        + (BFieldElement::from_raw_u64(5767629304344025219u64)))))
                + ((node_245)
                    * ((base_row[125usize])
                        + (BFieldElement::from_raw_u64(11578793764462375094u64)))),
            (((((node_102)
                * ((base_row[126usize])
                    + (BFieldElement::from_raw_u64(13209711277645656680u64))))
                + ((node_221)
                    * ((base_row[126usize])
                        + (BFieldElement::from_raw_u64(15235800289984546486u64)))))
                + ((base_row[155usize])
                    * ((base_row[126usize])
                        + (BFieldElement::from_raw_u64(15992731669612695172u64)))))
                + ((node_238)
                    * ((base_row[126usize])
                        + (BFieldElement::from_raw_u64(16721422493821450473u64)))))
                + ((node_245)
                    * ((base_row[126usize])
                        + (BFieldElement::from_raw_u64(7511767364422267184u64)))),
            (((((node_102)
                * ((base_row[127usize])
                    + (BFieldElement::from_raw_u64(87705059284758253u64))))
                + ((node_221)
                    * ((base_row[127usize])
                        + (BFieldElement::from_raw_u64(11392407538241985753u64)))))
                + ((base_row[155usize])
                    * ((base_row[127usize])
                        + (BFieldElement::from_raw_u64(17877154195438905917u64)))))
                + ((node_238)
                    * ((base_row[127usize])
                        + (BFieldElement::from_raw_u64(5753720429376839714u64)))))
                + ((node_245)
                    * ((base_row[127usize])
                        + (BFieldElement::from_raw_u64(16999805755930336630u64)))),
            (((((node_102)
                * ((base_row[128usize])
                    + (BFieldElement::from_raw_u64(330155256278907084u64))))
                + ((node_221)
                    * ((base_row[128usize])
                        + (BFieldElement::from_raw_u64(11776128816341368822u64)))))
                + ((base_row[155usize])
                    * ((base_row[128usize])
                        + (BFieldElement::from_raw_u64(939319986782105612u64)))))
                + ((node_238)
                    * ((base_row[128usize])
                        + (BFieldElement::from_raw_u64(2063756830275051942u64)))))
                + ((node_245)
                    * ((base_row[128usize])
                        + (BFieldElement::from_raw_u64(940614108343834936u64)))),
            (base_row[129usize])
                * ((BFieldElement::from_raw_u64(4294967295u64))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (base_row[129usize]))),
            (base_row[135usize])
                * ((BFieldElement::from_raw_u64(4294967295u64))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (base_row[135usize]))),
            (base_row[139usize])
                * ((BFieldElement::from_raw_u64(4294967295u64))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (base_row[139usize]))),
            (base_row[139usize]) * (base_row[140usize]),
            (BFieldElement::from_raw_u64(4294967295u64))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((base_row[141usize])
                        * ((base_row[140usize])
                            + (BFieldElement::from_raw_u64(18446743927680663586u64))))),
            (base_row[144usize]) * (node_655),
            (base_row[143usize]) * (node_655),
            (base_row[146usize]) * (node_660),
            (base_row[145usize]) * (node_660),
            (base_row[167usize])
                * ((base_row[147usize])
                    + (BFieldElement::from_raw_u64(18446744060824649731u64))),
            (base_row[168usize]) * (base_row[147usize]),
            (((base_row[163usize]) * (node_655)) * (node_660)) * (base_row[147usize]),
            (((base_row[166usize]) * (node_678)) * (node_660))
                * ((base_row[147usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))),
            (((base_row[164usize]) * (node_680)) * (node_655))
                * ((base_row[147usize]) + (BFieldElement::from_raw_u64(4294967295u64))),
            (((base_row[166usize]) * (node_674)) * (node_655)) * (base_row[147usize]),
            ((base_row[164usize]) * (base_row[139usize])) * (node_655),
            (node_680) * (base_row[148usize]),
            (base_row[151usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((base_row[64usize]) * (node_89))),
            (base_row[152usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((node_89) * (node_90)) * (node_94)) * (node_97))),
            (base_row[153usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((base_row[64usize]) * (node_90)) * (node_94)) * (node_97))),
            (base_row[154usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((base_row[151usize]) * (node_90))),
            (base_row[155usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((base_row[151usize]) * (node_94)) * (node_97)) * (node_101))),
            (base_row[156usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_663)
                        * ((base_row[142usize])
                            + (BFieldElement::from_raw_u64(18446744043644780551u64))))),
            (base_row[157usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((base_row[143usize]) * (base_row[144usize]))),
            (base_row[158usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((node_663) * (node_666)) * (node_670)) * (node_674))),
            (base_row[159usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((base_row[156usize]) * (node_666))),
            (base_row[160usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((base_row[145usize]) * (base_row[146usize]))),
            (base_row[161usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_86) * (base_row[62usize]))),
            (base_row[162usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((base_row[158usize]) * (node_678))),
            (base_row[163usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((base_row[156usize]) * (node_670)) * (node_674)) * (node_678))),
            (base_row[164usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((base_row[159usize]) * (node_674)) * (node_678))),
            (base_row[165usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((node_83) * (node_103)) * (base_row[62usize]))
                        * ((base_row[63usize])
                            + (BFieldElement::from_raw_u64(18446743897615892521u64))))),
            (base_row[166usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((base_row[159usize]) * (node_670))),
            (base_row[167usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((base_row[162usize]) * (node_680)) * (node_655)) * (node_660))),
            (base_row[168usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((base_row[162usize]) * (base_row[139usize])) * (node_655))
                        * (node_660))),
        ];
        let ext_constraints = [];
        base_constraints
            .into_iter()
            .map(|bfe| bfe.lift())
            .chain(ext_constraints)
            .collect()
    }
    #[allow(unused_variables)]
    fn evaluate_transition_constraints(
        current_base_row: ArrayView1<BFieldElement>,
        current_ext_row: ArrayView1<XFieldElement>,
        next_base_row: ArrayView1<BFieldElement>,
        next_ext_row: ArrayView1<XFieldElement>,
        challenges: &Challenges,
    ) -> Vec<XFieldElement> {
        let node_120 = (next_base_row[19usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[19usize]));
        let node_520 = (next_ext_row[3usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[3usize]));
        let node_524 = (next_ext_row[4usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[4usize]));
        let node_124 = (next_base_row[20usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[20usize]));
        let node_128 = (next_base_row[21usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[21usize]));
        let node_516 = (next_ext_row[7usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[7usize]));
        let node_2311 = (current_base_row[18usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_3926 = (BFieldElement::from_raw_u64(4294967295u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (next_base_row[8usize]));
        let node_261 = (next_base_row[38usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[38usize]));
        let node_1182 = ((next_base_row[9usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[9usize])))
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_2309 = (current_base_row[17usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_612 = (challenges[40usize]) * (current_base_row[30usize]);
        let node_614 = (challenges[41usize]) * (current_base_row[31usize]);
        let node_616 = (challenges[42usize]) * (current_base_row[32usize]);
        let node_618 = (challenges[43usize]) * (current_base_row[33usize]);
        let node_620 = (challenges[44usize]) * (current_base_row[34usize]);
        let node_622 = (challenges[45usize]) * (current_base_row[35usize]);
        let node_624 = (challenges[46usize]) * (current_base_row[36usize]);
        let node_861 = (challenges[47usize]) * (current_base_row[37usize]);
        let node_608 = (challenges[38usize]) * (current_base_row[28usize]);
        let node_610 = (challenges[39usize]) * (current_base_row[29usize]);
        let node_1177 = (next_ext_row[6usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[6usize]));
        let node_272 = ((challenges[16usize]) * (current_base_row[7usize]))
            + ((challenges[17usize]) * (current_base_row[13usize]));
        let node_606 = (challenges[37usize]) * (current_base_row[27usize]);
        let node_602 = (challenges[35usize]) * (current_base_row[25usize]);
        let node_604 = (challenges[36usize]) * (current_base_row[26usize]);
        let node_600 = (challenges[34usize]) * (current_base_row[24usize]);
        let node_5592 = (current_base_row[294usize])
            * ((next_base_row[64usize])
                + (BFieldElement::from_raw_u64(18446744052234715141u64)));
        let node_860 = ((((((((((((((((challenges[32usize]) * (next_base_row[22usize]))
            + ((challenges[33usize]) * (next_base_row[23usize])))
            + ((challenges[34usize]) * (next_base_row[24usize])))
            + ((challenges[35usize]) * (next_base_row[25usize])))
            + ((challenges[36usize]) * (next_base_row[26usize])))
            + ((challenges[37usize]) * (next_base_row[27usize])))
            + ((challenges[38usize]) * (next_base_row[28usize])))
            + ((challenges[39usize]) * (next_base_row[29usize])))
            + ((challenges[40usize]) * (next_base_row[30usize])))
            + ((challenges[41usize]) * (next_base_row[31usize])))
            + ((challenges[42usize]) * (next_base_row[32usize])))
            + ((challenges[43usize]) * (next_base_row[33usize])))
            + ((challenges[44usize]) * (next_base_row[34usize])))
            + ((challenges[45usize]) * (next_base_row[35usize])))
            + ((challenges[46usize]) * (next_base_row[36usize])))
            + ((challenges[47usize]) * (next_base_row[37usize]));
        let node_598 = (challenges[33usize]) * (current_base_row[23usize]);
        let node_5669 = (((next_base_row[63usize])
            + (BFieldElement::from_raw_u64(18446743992105173011u64)))
            * ((next_base_row[63usize])
                + (BFieldElement::from_raw_u64(18446743923385696291u64))))
            * ((next_base_row[63usize])
                + (BFieldElement::from_raw_u64(18446743828896415801u64)));
        let node_4646 = (((((current_base_row[81usize])
            * (BFieldElement::from_raw_u64(18446744069414518785u64)))
            + ((current_base_row[82usize])
                * (BFieldElement::from_raw_u64(18446744069414584320u64))))
            + ((current_base_row[83usize])
                * (BFieldElement::from_raw_u64(281474976645120u64))))
            + (current_base_row[84usize])) * (BFieldElement::from_raw_u64(1u64));
        let node_4657 = (((((current_base_row[85usize])
            * (BFieldElement::from_raw_u64(18446744069414518785u64)))
            + ((current_base_row[86usize])
                * (BFieldElement::from_raw_u64(18446744069414584320u64))))
            + ((current_base_row[87usize])
                * (BFieldElement::from_raw_u64(281474976645120u64))))
            + (current_base_row[88usize])) * (BFieldElement::from_raw_u64(1u64));
        let node_4668 = (((((current_base_row[89usize])
            * (BFieldElement::from_raw_u64(18446744069414518785u64)))
            + ((current_base_row[90usize])
                * (BFieldElement::from_raw_u64(18446744069414584320u64))))
            + ((current_base_row[91usize])
                * (BFieldElement::from_raw_u64(281474976645120u64))))
            + (current_base_row[92usize])) * (BFieldElement::from_raw_u64(1u64));
        let node_4679 = (((((current_base_row[93usize])
            * (BFieldElement::from_raw_u64(18446744069414518785u64)))
            + ((current_base_row[94usize])
                * (BFieldElement::from_raw_u64(18446744069414584320u64))))
            + ((current_base_row[95usize])
                * (BFieldElement::from_raw_u64(281474976645120u64))))
            + (current_base_row[96usize])) * (BFieldElement::from_raw_u64(1u64));
        let node_1274 = ((current_base_row[7usize]) * (challenges[20usize]))
            + (challenges[23usize]);
        let node_810 = (next_base_row[22usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[22usize]));
        let node_538 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_base_row[27usize]);
        let node_536 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_base_row[26usize]);
        let node_540 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_base_row[28usize]);
        let node_542 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_base_row[29usize]);
        let node_2307 = (current_base_row[16usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_534 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_base_row[25usize]);
        let node_544 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_base_row[30usize]);
        let node_546 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_base_row[31usize]);
        let node_548 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_base_row[32usize]);
        let node_116 = ((next_base_row[9usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[9usize])))
            + (BFieldElement::from_raw_u64(18446744060824649731u64));
        let node_1232 = (next_base_row[25usize]) + (node_536);
        let node_1233 = (next_base_row[26usize]) + (node_538);
        let node_1234 = (next_base_row[27usize]) + (node_540);
        let node_1235 = (next_base_row[28usize]) + (node_542);
        let node_1236 = (next_base_row[29usize]) + (node_544);
        let node_1237 = (next_base_row[30usize]) + (node_546);
        let node_262 = (node_261) + (BFieldElement::from_raw_u64(4294967295u64));
        let node_1238 = (next_base_row[31usize]) + (node_548);
        let node_1239 = (next_base_row[32usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[33usize]));
        let node_1240 = (next_base_row[33usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[34usize]));
        let node_1241 = (next_base_row[34usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[35usize]));
        let node_1242 = (next_base_row[35usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[36usize]));
        let node_1243 = (next_base_row[36usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[37usize]));
        let node_286 = (next_ext_row[6usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((current_ext_row[6usize])
                    * ((challenges[7usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((node_272)
                                + ((challenges[18usize]) * (next_base_row[38usize])))
                                + ((challenges[19usize]) * (next_base_row[37usize])))))));
        let node_6058 = (next_base_row[139usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_550 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_base_row[33usize]);
        let node_1230 = (next_base_row[23usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[24usize]));
        let node_1231 = (next_base_row[24usize]) + (node_534);
        let node_4413 = (BFieldElement::from_raw_u64(4294967295u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (((next_base_row[52usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_base_row[52usize]))) * (current_base_row[54usize])));
        let node_4075 = (BFieldElement::from_raw_u64(4294967295u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (next_base_row[44usize]));
        let node_530 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_base_row[23usize]);
        let node_532 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_base_row[24usize]);
        let node_552 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_base_row[34usize]);
        let node_864 = (node_860)
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (((((((((((((((((challenges[32usize]) * (current_base_row[22usize]))
                    + (node_598)) + (node_600)) + (node_602)) + (node_604)) + (node_606))
                    + (node_608)) + (node_610)) + (node_612)) + (node_614)) + (node_616))
                    + (node_618)) + (node_620)) + (node_622)) + (node_624))
                    + (node_861)));
        let node_554 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_base_row[35usize]);
        let node_154 = ((((current_base_row[11usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((BFieldElement::from_raw_u64(34359738360u64))
                    * (current_base_row[42usize]))))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((BFieldElement::from_raw_u64(17179869180u64))
                    * (current_base_row[41usize]))))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((BFieldElement::from_raw_u64(8589934590u64))
                    * (current_base_row[40usize]))))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[39usize]));
        let node_341 = (BFieldElement::from_raw_u64(4294967295u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[39usize]));
        let node_556 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_base_row[36usize]);
        let node_209 = (challenges[40usize]) * (next_base_row[30usize]);
        let node_212 = (challenges[41usize]) * (next_base_row[31usize]);
        let node_215 = (challenges[42usize]) * (next_base_row[32usize]);
        let node_218 = (challenges[43usize]) * (next_base_row[33usize]);
        let node_221 = (challenges[44usize]) * (next_base_row[34usize]);
        let node_224 = (challenges[45usize]) * (next_base_row[35usize]);
        let node_227 = (challenges[46usize]) * (next_base_row[36usize]);
        let node_859 = (challenges[47usize]) * (next_base_row[37usize]);
        let node_4282 = (next_ext_row[12usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[12usize]));
        let node_4410 = (next_base_row[52usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[52usize]));
        let node_5435 = (next_base_row[62usize])
            + (BFieldElement::from_raw_u64(18446744056529682436u64));
        let node_6054 = (current_base_row[145usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((BFieldElement::from_raw_u64(8589934590u64))
                    * (next_base_row[145usize])));
        let node_854 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_base_row[37usize]);
        let node_203 = (challenges[38usize]) * (next_base_row[28usize]);
        let node_206 = (challenges[39usize]) * (next_base_row[29usize]);
        let node_512 = ((((((((((current_base_row[283usize])
            + (current_base_row[284usize])) + (current_base_row[285usize]))
            + (current_base_row[286usize])) + (current_base_row[287usize]))
            + (current_base_row[288usize])) + (current_base_row[289usize]))
            + (current_base_row[290usize])) + (current_base_row[291usize]))
            + (current_base_row[292usize])) + (current_base_row[293usize]);
        let node_6051 = (current_base_row[143usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((BFieldElement::from_raw_u64(8589934590u64))
                    * (next_base_row[143usize])));
        let node_2305 = (current_base_row[15usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_1272 = (current_base_row[7usize]) * (challenges[20usize]);
        let node_525 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_base_row[11usize]);
        let node_200 = (challenges[37usize]) * (next_base_row[27usize]);
        let node_2049 = (challenges[1usize]) * (current_ext_row[3usize]);
        let node_5439 = (next_base_row[63usize])
            + (BFieldElement::from_raw_u64(18446743897615892521u64));
        let node_1184 = (current_base_row[279usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_1255 = (BFieldElement::from_raw_u64(4294967295u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[271usize]));
        let node_528 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_base_row[22usize]);
        let node_113 = (next_base_row[9usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[9usize]));
        let node_531 = (next_base_row[24usize]) + (node_530);
        let node_533 = (next_base_row[25usize]) + (node_532);
        let node_535 = (next_base_row[26usize]) + (node_534);
        let node_537 = (next_base_row[27usize]) + (node_536);
        let node_194 = (challenges[35usize]) * (next_base_row[25usize]);
        let node_197 = (challenges[36usize]) * (next_base_row[26usize]);
        let node_539 = (next_base_row[28usize]) + (node_538);
        let node_1909 = ((((((((((((((((challenges[33usize]) * (next_base_row[23usize]))
            + ((challenges[34usize]) * (next_base_row[24usize]))) + (node_194))
            + (node_197)) + (node_200)) + (node_203)) + (node_206)) + (node_209))
            + (node_212)) + (node_215)) + (node_218)) + (node_221)) + (node_224))
            + (node_227)) + (node_859))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (((((((((((((((node_598) + (node_600)) + (node_602)) + (node_604))
                    + (node_606)) + (node_608)) + (node_610)) + (node_612)) + (node_614))
                    + (node_616)) + (node_618)) + (node_620)) + (node_622)) + (node_624))
                    + (node_861)));
        let node_541 = (next_base_row[29usize]) + (node_540);
        let node_543 = (next_base_row[30usize]) + (node_542);
        let node_545 = (next_base_row[31usize]) + (node_544);
        let node_558 = (node_261)
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_547 = (next_base_row[32usize]) + (node_546);
        let node_549 = (next_base_row[33usize]) + (node_548);
        let node_551 = (next_base_row[34usize]) + (node_550);
        let node_553 = (next_base_row[35usize]) + (node_552);
        let node_555 = (next_base_row[36usize]) + (node_554);
        let node_557 = (next_base_row[37usize]) + (node_556);
        let node_567 = (next_ext_row[6usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((current_ext_row[6usize])
                    * ((challenges[7usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((node_272)
                                + ((challenges[18usize]) * (current_base_row[38usize])))
                                + ((challenges[19usize])
                                    * (current_base_row[37usize])))))));
        let node_5306 = (((((next_base_row[65usize])
            * (BFieldElement::from_raw_u64(18446744069414518785u64)))
            + ((next_base_row[66usize])
                * (BFieldElement::from_raw_u64(18446744069414584320u64))))
            + ((next_base_row[67usize])
                * (BFieldElement::from_raw_u64(281474976645120u64))))
            + (next_base_row[68usize])) * (BFieldElement::from_raw_u64(1u64));
        let node_5317 = (((((next_base_row[69usize])
            * (BFieldElement::from_raw_u64(18446744069414518785u64)))
            + ((next_base_row[70usize])
                * (BFieldElement::from_raw_u64(18446744069414584320u64))))
            + ((next_base_row[71usize])
                * (BFieldElement::from_raw_u64(281474976645120u64))))
            + (next_base_row[72usize])) * (BFieldElement::from_raw_u64(1u64));
        let node_5328 = (((((next_base_row[73usize])
            * (BFieldElement::from_raw_u64(18446744069414518785u64)))
            + ((next_base_row[74usize])
                * (BFieldElement::from_raw_u64(18446744069414584320u64))))
            + ((next_base_row[75usize])
                * (BFieldElement::from_raw_u64(281474976645120u64))))
            + (next_base_row[76usize])) * (BFieldElement::from_raw_u64(1u64));
        let node_5339 = (((((next_base_row[77usize])
            * (BFieldElement::from_raw_u64(18446744069414518785u64)))
            + ((next_base_row[78usize])
                * (BFieldElement::from_raw_u64(18446744069414584320u64))))
            + ((next_base_row[79usize])
                * (BFieldElement::from_raw_u64(281474976645120u64))))
            + (next_base_row[80usize])) * (BFieldElement::from_raw_u64(1u64));
        let node_5430 = (next_base_row[62usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_5998 = (BFieldElement::from_raw_u64(4294967295u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (next_base_row[135usize]));
        let node_6085 = (next_base_row[142usize])
            + (BFieldElement::from_raw_u64(18446743940565565471u64));
        let node_2303 = (current_base_row[14usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_293 = (BFieldElement::from_raw_u64(4294967295u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[40usize]));
        let node_6089 = (next_base_row[142usize])
            + (BFieldElement::from_raw_u64(18446743949155500061u64));
        let node_34 = (BFieldElement::from_raw_u64(4294967295u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((current_base_row[4usize])
                    * ((BFieldElement::from_raw_u64(38654705655u64))
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (current_base_row[3usize])))));
        let node_812 = (next_base_row[22usize]) + (node_530);
        let node_1918 = (BFieldElement::from_raw_u64(4294967295u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[322usize]));
        let node_1970 = (next_base_row[24usize]) + (node_532);
        let node_2186 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (next_ext_row[7usize]);
        let node_1585 = (next_base_row[25usize]) + (node_540);
        let node_1586 = (next_base_row[26usize]) + (node_542);
        let node_191 = (challenges[34usize]) * (next_base_row[24usize]);
        let node_1587 = (next_base_row[27usize]) + (node_544);
        let node_1588 = (next_base_row[28usize]) + (node_546);
        let node_1820 = (((((((((((node_200) + (node_203)) + (node_206)) + (node_209))
            + (node_212)) + (node_215)) + (node_218)) + (node_221)) + (node_224))
            + (node_227)) + (node_859))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (((((((((((node_606) + (node_608)) + (node_610)) + (node_612))
                    + (node_614)) + (node_616)) + (node_618)) + (node_620)) + (node_622))
                    + (node_624)) + (node_861)));
        let node_1589 = (next_base_row[29usize]) + (node_548);
        let node_1590 = (next_base_row[30usize]) + (node_550);
        let node_476 = (((((current_base_row[195usize]) * (node_262))
            + ((current_base_row[196usize])
                * ((node_261) + (BFieldElement::from_raw_u64(8589934590u64)))))
            + ((current_base_row[197usize])
                * ((node_261) + (BFieldElement::from_raw_u64(12884901885u64)))))
            + ((current_base_row[198usize])
                * ((node_261) + (BFieldElement::from_raw_u64(17179869180u64)))))
            + ((current_base_row[199usize])
                * ((node_261) + (BFieldElement::from_raw_u64(21474836475u64))));
        let node_801 = (((((current_base_row[195usize]) * (node_558))
            + ((current_base_row[196usize])
                * ((node_261) + (BFieldElement::from_raw_u64(18446744060824649731u64)))))
            + ((current_base_row[197usize])
                * ((node_261) + (BFieldElement::from_raw_u64(18446744056529682436u64)))))
            + ((current_base_row[198usize])
                * ((node_261) + (BFieldElement::from_raw_u64(18446744052234715141u64)))))
            + ((current_base_row[199usize])
                * ((node_261) + (BFieldElement::from_raw_u64(18446744047939747846u64))));
        let node_455 = (node_261) + (BFieldElement::from_raw_u64(21474836475u64));
        let node_1591 = (next_base_row[31usize]) + (node_552);
        let node_1592 = (next_base_row[32usize]) + (node_554);
        let node_484 = ((((current_ext_row[74usize]) + (current_ext_row[75usize]))
            + (current_ext_row[76usize])) + (current_ext_row[77usize]))
            + ((current_base_row[199usize])
                * ((next_ext_row[6usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_ext_row[59usize]))));
        let node_809 = ((((current_ext_row[78usize]) + (current_ext_row[79usize]))
            + (current_ext_row[80usize])) + (current_ext_row[81usize]))
            + (current_ext_row[82usize]);
        let node_468 = (next_ext_row[6usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[59usize]));
        let node_1593 = (next_base_row[33usize]) + (node_556);
        let node_1594 = (next_base_row[34usize]) + (node_854);
        let node_372 = (node_261) + (BFieldElement::from_raw_u64(12884901885u64));
        let node_385 = (next_ext_row[6usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((current_ext_row[6usize]) * (current_ext_row[52usize])));
        let node_4048 = (next_base_row[18usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_4193 = ((next_ext_row[11usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((challenges[6usize]) * (current_ext_row[11usize]))))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((challenges[31usize]) * (current_base_row[10usize])));
        let node_4239 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * ((challenges[57usize]) * (current_base_row[10usize]));
        let node_4286 = ((node_4282)
            * (((((challenges[10usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((challenges[55usize]) * (current_base_row[22usize]))))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((challenges[56usize]) * (current_base_row[23usize]))))
                + (node_4239))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((challenges[58usize]) * (next_base_row[22usize])))))
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_4243 = (challenges[10usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((challenges[55usize]) * (current_base_row[22usize])));
        let node_4336 = ((next_base_row[48usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[48usize])))
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_4335 = (next_base_row[48usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[48usize]));
        let node_4342 = (next_base_row[47usize])
            + (BFieldElement::from_raw_u64(18446744060824649731u64));
        let node_4368 = (next_ext_row[15usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[15usize]));
        let node_4405 = (next_base_row[51usize])
            + (BFieldElement::from_raw_u64(18446744060824649731u64));
        let node_4488 = (next_ext_row[21usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[21usize]));
        let node_4517 = ((next_base_row[59usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[59usize])))
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_4516 = (next_base_row[59usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[59usize]));
        let node_4524 = ((node_4517)
            * ((current_base_row[58usize])
                + (BFieldElement::from_raw_u64(18446744000695107601u64))))
            * ((current_base_row[58usize])
                + (BFieldElement::from_raw_u64(18446743931975630881u64)));
        let node_5427 = (current_base_row[62usize])
            + (BFieldElement::from_raw_u64(18446744056529682436u64));
        let node_5491 = (next_base_row[64usize])
            + (BFieldElement::from_raw_u64(18446744047939747846u64));
        let node_5542 = (next_base_row[63usize])
            + (BFieldElement::from_raw_u64(18446743992105173011u64));
        let node_5544 = (next_base_row[63usize])
            + (BFieldElement::from_raw_u64(18446743923385696291u64));
        let node_5661 = (next_ext_row[28usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[28usize]));
        let node_5682 = (next_ext_row[29usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[29usize]));
        let node_5699 = (next_ext_row[30usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[30usize]));
        let node_5716 = (next_ext_row[31usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[31usize]));
        let node_5733 = (next_ext_row[32usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[32usize]));
        let node_5750 = (next_ext_row[33usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[33usize]));
        let node_5767 = (next_ext_row[34usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[34usize]));
        let node_5784 = (next_ext_row[35usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[35usize]));
        let node_5801 = (next_ext_row[36usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[36usize]));
        let node_5818 = (next_ext_row[37usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[37usize]));
        let node_5835 = (next_ext_row[38usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[38usize]));
        let node_5852 = (next_ext_row[39usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[39usize]));
        let node_5869 = (next_ext_row[40usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[40usize]));
        let node_5886 = (next_ext_row[41usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[41usize]));
        let node_5903 = (next_ext_row[42usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[42usize]));
        let node_5920 = (next_ext_row[43usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[43usize]));
        let node_5946 = (BFieldElement::from_raw_u64(4294967295u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (next_base_row[129usize]));
        let node_6048 = (current_base_row[142usize])
            + (BFieldElement::from_raw_u64(18446743940565565471u64));
        let node_6075 = (node_6054)
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_6083 = (next_base_row[142usize])
            + (BFieldElement::from_raw_u64(18446744017874976781u64));
        let node_5451 = (next_base_row[62usize])
            + (BFieldElement::from_raw_u64(18446744060824649731u64));
        let node_2159 = (current_base_row[40usize]) * (challenges[22usize]);
        let node_2166 = (current_base_row[41usize]) * (challenges[22usize]);
        let node_2173 = (current_base_row[42usize]) * (challenges[22usize]);
        let node_30 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_base_row[3usize]);
        let node_47 = (next_base_row[6usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_51 = (next_ext_row[0usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[0usize]));
        let node_31 = (BFieldElement::from_raw_u64(38654705655u64)) + (node_30);
        let node_74 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (next_base_row[1usize]);
        let node_90 = (BFieldElement::from_raw_u64(38654705655u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (next_base_row[3usize]));
        let node_88 = (next_ext_row[2usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[2usize]));
        let node_229 = (challenges[32usize]) * (current_base_row[23usize]);
        let node_299 = (challenges[32usize]) * (current_base_row[24usize]);
        let node_346 = (challenges[32usize]) * (current_base_row[25usize]);
        let node_390 = (challenges[32usize]) * (current_base_row[26usize]);
        let node_433 = (challenges[32usize]) * (current_base_row[27usize]);
        let node_1050 = (challenges[32usize]) * (current_base_row[32usize]);
        let node_1181 = (next_base_row[10usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[10usize]));
        let node_1249 = (node_120) + (BFieldElement::from_raw_u64(4294967295u64));
        let node_1251 = (next_base_row[9usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[21usize]));
        let node_1912 = (next_base_row[22usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((current_base_row[22usize]) * (current_base_row[23usize])));
        let node_1913 = (next_base_row[22usize]) * (current_base_row[22usize]);
        let node_1934 = (current_base_row[23usize]) * (next_base_row[23usize]);
        let node_1937 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (next_base_row[22usize]);
        let node_1972 = (current_base_row[22usize]) * (current_base_row[25usize]);
        let node_1983 = ((current_base_row[24usize]) * (current_base_row[26usize]))
            + ((current_base_row[23usize]) * (current_base_row[27usize]));
        let node_1997 = (current_base_row[24usize]) * (next_base_row[23usize]);
        let node_2000 = (current_base_row[23usize]) * (next_base_row[24usize]);
        let node_1571 = (node_810)
            + (BFieldElement::from_raw_u64(18446744056529682436u64));
        let node_1505 = (node_810)
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_529 = (next_base_row[23usize]) + (node_528);
        let node_112 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_base_row[9usize]);
        let node_1250 = (next_base_row[9usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[20usize]));
        let node_1252 = (current_base_row[28usize]) + (node_538);
        let node_1915 = (current_base_row[23usize]) + (node_528);
        let node_1968 = (next_base_row[23usize]) + (node_530);
        let node_2126 = (((BFieldElement::from_raw_u64(8589934590u64))
            * (next_base_row[27usize])) + (current_base_row[44usize])) + (node_538);
        let node_2210 = (node_1968)
            + (BFieldElement::from_raw_u64(18446744056529682436u64));
        let node_292 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_base_row[40usize]);
        let node_144 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * ((BFieldElement::from_raw_u64(34359738360u64))
                * (current_base_row[42usize]));
        let node_2258 = ((current_base_row[41usize]) * (current_base_row[43usize]))
            + ((current_base_row[40usize]) * (current_base_row[44usize]));
        let node_1661 = (next_base_row[27usize]) + (node_548);
        let node_2268 = (next_base_row[25usize]) + (node_534);
        let node_2259 = (current_base_row[41usize]) * (current_base_row[44usize]);
        let node_1662 = (next_base_row[28usize]) + (node_550);
        let node_201 = ((((((challenges[32usize]) * (next_base_row[22usize]))
            + ((challenges[33usize]) * (next_base_row[23usize]))) + (node_191))
            + (node_194)) + (node_197)) + (node_200);
        let node_607 = ((((((challenges[32usize]) * (current_base_row[22usize]))
            + (node_598)) + (node_600)) + (node_602)) + (node_604)) + (node_606);
        let node_2271 = (next_base_row[26usize]) + (node_536);
        let node_1663 = (next_base_row[29usize]) + (node_552);
        let node_1664 = (next_base_row[30usize]) + (node_554);
        let node_1665 = (next_base_row[31usize]) + (node_556);
        let node_1666 = (next_base_row[32usize]) + (node_854);
        let node_480 = (((((current_base_row[195usize])
            * (((((((((((node_201) + (node_203)) + (node_206)) + (node_209))
                + (node_212)) + (node_215)) + (node_218)) + (node_221)) + (node_224))
                + (node_227))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((((((((((((((node_229)
                        + ((challenges[33usize]) * (current_base_row[24usize])))
                        + ((challenges[34usize]) * (current_base_row[25usize])))
                        + ((challenges[35usize]) * (current_base_row[26usize])))
                        + ((challenges[36usize]) * (current_base_row[27usize])))
                        + ((challenges[37usize]) * (current_base_row[28usize])))
                        + ((challenges[38usize]) * (current_base_row[29usize])))
                        + ((challenges[39usize]) * (current_base_row[30usize])))
                        + ((challenges[40usize]) * (current_base_row[31usize])))
                        + ((challenges[41usize]) * (current_base_row[32usize])))
                        + ((challenges[42usize]) * (current_base_row[33usize])))
                        + ((challenges[43usize]) * (current_base_row[34usize])))
                        + ((challenges[44usize]) * (current_base_row[35usize])))
                        + ((challenges[45usize]) * (current_base_row[36usize])))
                        + ((challenges[46usize]) * (current_base_row[37usize]))))))
            + ((current_base_row[196usize])
                * ((((((((((node_201) + (node_203)) + (node_206)) + (node_209))
                    + (node_212)) + (node_215)) + (node_218)) + (node_221)) + (node_224))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((((((((((((((node_299)
                            + ((challenges[33usize]) * (current_base_row[25usize])))
                            + ((challenges[34usize]) * (current_base_row[26usize])))
                            + ((challenges[35usize]) * (current_base_row[27usize])))
                            + ((challenges[36usize]) * (current_base_row[28usize])))
                            + ((challenges[37usize]) * (current_base_row[29usize])))
                            + ((challenges[38usize]) * (current_base_row[30usize])))
                            + ((challenges[39usize]) * (current_base_row[31usize])))
                            + ((challenges[40usize]) * (current_base_row[32usize])))
                            + ((challenges[41usize]) * (current_base_row[33usize])))
                            + ((challenges[42usize]) * (current_base_row[34usize])))
                            + ((challenges[43usize]) * (current_base_row[35usize])))
                            + ((challenges[44usize]) * (current_base_row[36usize])))
                            + ((challenges[45usize]) * (current_base_row[37usize])))))))
            + ((current_base_row[197usize])
                * (((((((((node_201) + (node_203)) + (node_206)) + (node_209))
                    + (node_212)) + (node_215)) + (node_218)) + (node_221))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (((((((((((((node_346)
                            + ((challenges[33usize]) * (current_base_row[26usize])))
                            + ((challenges[34usize]) * (current_base_row[27usize])))
                            + ((challenges[35usize]) * (current_base_row[28usize])))
                            + ((challenges[36usize]) * (current_base_row[29usize])))
                            + ((challenges[37usize]) * (current_base_row[30usize])))
                            + ((challenges[38usize]) * (current_base_row[31usize])))
                            + ((challenges[39usize]) * (current_base_row[32usize])))
                            + ((challenges[40usize]) * (current_base_row[33usize])))
                            + ((challenges[41usize]) * (current_base_row[34usize])))
                            + ((challenges[42usize]) * (current_base_row[35usize])))
                            + ((challenges[43usize]) * (current_base_row[36usize])))
                            + ((challenges[44usize]) * (current_base_row[37usize])))))))
            + ((current_base_row[198usize])
                * ((((((((node_201) + (node_203)) + (node_206)) + (node_209))
                    + (node_212)) + (node_215)) + (node_218))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((((((((((((node_390)
                            + ((challenges[33usize]) * (current_base_row[27usize])))
                            + ((challenges[34usize]) * (current_base_row[28usize])))
                            + ((challenges[35usize]) * (current_base_row[29usize])))
                            + ((challenges[36usize]) * (current_base_row[30usize])))
                            + ((challenges[37usize]) * (current_base_row[31usize])))
                            + ((challenges[38usize]) * (current_base_row[32usize])))
                            + ((challenges[39usize]) * (current_base_row[33usize])))
                            + ((challenges[40usize]) * (current_base_row[34usize])))
                            + ((challenges[41usize]) * (current_base_row[35usize])))
                            + ((challenges[42usize]) * (current_base_row[36usize])))
                            + ((challenges[43usize]) * (current_base_row[37usize])))))))
            + ((current_base_row[199usize])
                * (((((((node_201) + (node_203)) + (node_206)) + (node_209))
                    + (node_212)) + (node_215))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (((((((((((node_433)
                            + ((challenges[33usize]) * (current_base_row[28usize])))
                            + ((challenges[34usize]) * (current_base_row[29usize])))
                            + ((challenges[35usize]) * (current_base_row[30usize])))
                            + ((challenges[36usize]) * (current_base_row[31usize])))
                            + ((challenges[37usize]) * (current_base_row[32usize])))
                            + ((challenges[38usize]) * (current_base_row[33usize])))
                            + ((challenges[39usize]) * (current_base_row[34usize])))
                            + ((challenges[40usize]) * (current_base_row[35usize])))
                            + ((challenges[41usize]) * (current_base_row[36usize])))
                            + ((challenges[42usize]) * (current_base_row[37usize]))))));
        let node_805 = (((((current_base_row[195usize])
            * (((((((((((((((((challenges[32usize]) * (next_base_row[23usize]))
                + ((challenges[33usize]) * (next_base_row[24usize])))
                + ((challenges[34usize]) * (next_base_row[25usize])))
                + ((challenges[35usize]) * (next_base_row[26usize])))
                + ((challenges[36usize]) * (next_base_row[27usize])))
                + ((challenges[37usize]) * (next_base_row[28usize])))
                + ((challenges[38usize]) * (next_base_row[29usize])))
                + ((challenges[39usize]) * (next_base_row[30usize])))
                + ((challenges[40usize]) * (next_base_row[31usize])))
                + ((challenges[41usize]) * (next_base_row[32usize])))
                + ((challenges[42usize]) * (next_base_row[33usize])))
                + ((challenges[43usize]) * (next_base_row[34usize])))
                + ((challenges[44usize]) * (next_base_row[35usize])))
                + ((challenges[45usize]) * (next_base_row[36usize])))
                + ((challenges[46usize]) * (next_base_row[37usize])))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((((((((node_607) + (node_608)) + (node_610)) + (node_612))
                        + (node_614)) + (node_616)) + (node_618)) + (node_620))
                        + (node_622)) + (node_624)))))
            + ((current_base_row[196usize])
                * ((((((((((((((((challenges[32usize]) * (next_base_row[24usize]))
                    + ((challenges[33usize]) * (next_base_row[25usize])))
                    + ((challenges[34usize]) * (next_base_row[26usize])))
                    + ((challenges[35usize]) * (next_base_row[27usize])))
                    + ((challenges[36usize]) * (next_base_row[28usize])))
                    + ((challenges[37usize]) * (next_base_row[29usize])))
                    + ((challenges[38usize]) * (next_base_row[30usize])))
                    + ((challenges[39usize]) * (next_base_row[31usize])))
                    + ((challenges[40usize]) * (next_base_row[32usize])))
                    + ((challenges[41usize]) * (next_base_row[33usize])))
                    + ((challenges[42usize]) * (next_base_row[34usize])))
                    + ((challenges[43usize]) * (next_base_row[35usize])))
                    + ((challenges[44usize]) * (next_base_row[36usize])))
                    + ((challenges[45usize]) * (next_base_row[37usize])))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (((((((((node_607) + (node_608)) + (node_610)) + (node_612))
                            + (node_614)) + (node_616)) + (node_618)) + (node_620))
                            + (node_622))))))
            + ((current_base_row[197usize])
                * (((((((((((((((challenges[32usize]) * (next_base_row[25usize]))
                    + ((challenges[33usize]) * (next_base_row[26usize])))
                    + ((challenges[34usize]) * (next_base_row[27usize])))
                    + ((challenges[35usize]) * (next_base_row[28usize])))
                    + ((challenges[36usize]) * (next_base_row[29usize])))
                    + ((challenges[37usize]) * (next_base_row[30usize])))
                    + ((challenges[38usize]) * (next_base_row[31usize])))
                    + ((challenges[39usize]) * (next_base_row[32usize])))
                    + ((challenges[40usize]) * (next_base_row[33usize])))
                    + ((challenges[41usize]) * (next_base_row[34usize])))
                    + ((challenges[42usize]) * (next_base_row[35usize])))
                    + ((challenges[43usize]) * (next_base_row[36usize])))
                    + ((challenges[44usize]) * (next_base_row[37usize])))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((((((((node_607) + (node_608)) + (node_610)) + (node_612))
                            + (node_614)) + (node_616)) + (node_618)) + (node_620))))))
            + ((current_base_row[198usize])
                * ((((((((((((((challenges[32usize]) * (next_base_row[26usize]))
                    + ((challenges[33usize]) * (next_base_row[27usize])))
                    + ((challenges[34usize]) * (next_base_row[28usize])))
                    + ((challenges[35usize]) * (next_base_row[29usize])))
                    + ((challenges[36usize]) * (next_base_row[30usize])))
                    + ((challenges[37usize]) * (next_base_row[31usize])))
                    + ((challenges[38usize]) * (next_base_row[32usize])))
                    + ((challenges[39usize]) * (next_base_row[33usize])))
                    + ((challenges[40usize]) * (next_base_row[34usize])))
                    + ((challenges[41usize]) * (next_base_row[35usize])))
                    + ((challenges[42usize]) * (next_base_row[36usize])))
                    + ((challenges[43usize]) * (next_base_row[37usize])))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (((((((node_607) + (node_608)) + (node_610)) + (node_612))
                            + (node_614)) + (node_616)) + (node_618))))))
            + ((current_base_row[199usize])
                * (((((((((((((challenges[32usize]) * (next_base_row[27usize]))
                    + ((challenges[33usize]) * (next_base_row[28usize])))
                    + ((challenges[34usize]) * (next_base_row[29usize])))
                    + ((challenges[35usize]) * (next_base_row[30usize])))
                    + ((challenges[36usize]) * (next_base_row[31usize])))
                    + ((challenges[37usize]) * (next_base_row[32usize])))
                    + ((challenges[38usize]) * (next_base_row[33usize])))
                    + ((challenges[39usize]) * (next_base_row[34usize])))
                    + ((challenges[40usize]) * (next_base_row[35usize])))
                    + ((challenges[41usize]) * (next_base_row[36usize])))
                    + ((challenges[42usize]) * (next_base_row[37usize])))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((((((node_607) + (node_608)) + (node_610)) + (node_612))
                            + (node_614)) + (node_616)))));
        let node_457 = ((((((node_201) + (node_203)) + (node_206)) + (node_209))
            + (node_212)) + (node_215))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (((((((((((node_433)
                    + ((challenges[33usize]) * (current_base_row[28usize])))
                    + ((challenges[34usize]) * (current_base_row[29usize])))
                    + ((challenges[35usize]) * (current_base_row[30usize])))
                    + ((challenges[36usize]) * (current_base_row[31usize])))
                    + ((challenges[37usize]) * (current_base_row[32usize])))
                    + ((challenges[38usize]) * (current_base_row[33usize])))
                    + ((challenges[39usize]) * (current_base_row[34usize])))
                    + ((challenges[40usize]) * (current_base_row[35usize])))
                    + ((challenges[41usize]) * (current_base_row[36usize])))
                    + ((challenges[42usize]) * (current_base_row[37usize]))));
        let node_2096 = ((challenges[2usize]) * (current_ext_row[4usize]))
            + (current_base_row[22usize]);
        let node_2101 = ((challenges[2usize]) * (node_2096))
            + (current_base_row[23usize]);
        let node_2106 = ((challenges[2usize]) * (node_2101))
            + (current_base_row[24usize]);
        let node_2111 = ((challenges[2usize]) * (node_2106))
            + (current_base_row[25usize]);
        let node_4002 = (next_ext_row[5usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[5usize]));
        let node_4138 = (next_ext_row[9usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((challenges[4usize]) * (current_ext_row[9usize])));
        let node_4139 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (((((node_201) + (node_203)) + (node_206)) + (node_209)) + (node_212));
        let node_4144 = (node_4138)
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (((((((((((challenges[32usize])
                    * ((current_base_row[332usize]) + (current_base_row[333usize])))
                    + ((challenges[33usize])
                        * ((current_base_row[334usize]) + (current_base_row[335usize]))))
                    + ((challenges[34usize])
                        * ((current_base_row[336usize]) + (current_base_row[337usize]))))
                    + ((challenges[35usize])
                        * ((current_base_row[338usize]) + (current_base_row[339usize]))))
                    + ((challenges[36usize])
                        * ((current_base_row[340usize]) + (current_base_row[341usize]))))
                    + ((challenges[37usize])
                        * ((current_base_row[342usize]) + (current_base_row[343usize]))))
                    + ((challenges[38usize])
                        * ((current_base_row[344usize]) + (current_base_row[345usize]))))
                    + ((challenges[39usize])
                        * ((current_base_row[346usize]) + (current_base_row[347usize]))))
                    + ((challenges[40usize])
                        * ((current_base_row[348usize]) + (current_base_row[349usize]))))
                    + ((challenges[41usize])
                        * ((current_base_row[350usize])
                            + (current_base_row[351usize])))));
        let node_198 = (((((challenges[32usize]) * (next_base_row[22usize]))
            + ((challenges[33usize]) * (next_base_row[23usize]))) + (node_191))
            + (node_194)) + (node_197);
        let node_615 = ((((node_607) + (node_608)) + (node_610)) + (node_612))
            + (node_614);
        let node_4189 = (next_ext_row[11usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((challenges[6usize]) * (current_ext_row[11usize])));
        let node_574 = ((((challenges[32usize]) * (next_base_row[23usize]))
            + ((challenges[33usize]) * (next_base_row[24usize])))
            + ((challenges[34usize]) * (next_base_row[25usize])))
            + ((challenges[35usize]) * (next_base_row[26usize]));
        let node_4232 = (challenges[10usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((challenges[55usize]) * (next_base_row[22usize])));
        let node_4235 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * ((challenges[56usize]) * (next_base_row[23usize]));
        let node_4246 = (node_4243)
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((challenges[56usize]) * (current_base_row[23usize])));
        let node_4290 = ((node_4282)
            * (((node_4243) + (node_4239))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((challenges[58usize]) * (next_base_row[22usize])))))
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_4269 = (((node_4232)
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((challenges[56usize]) * (current_base_row[23usize]))))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((challenges[57usize])
                    * (BFieldElement::from_raw_u64(25769803770u64)))))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (challenges[58usize]));
        let node_4273 = ((node_4243) + (node_4235))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((challenges[57usize])
                    * (BFieldElement::from_raw_u64(17179869180u64))));
        let node_4292 = ((node_4282)
            * ((((challenges[10usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((challenges[55usize]) * (current_base_row[27usize]))))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((challenges[56usize]) * (next_base_row[27usize]))))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((challenges[57usize])
                        * (BFieldElement::from_raw_u64(17179869180u64))))))
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_4359 = (next_base_row[47usize])
            * ((next_base_row[47usize])
                + (BFieldElement::from_raw_u64(18446744065119617026u64)));
        let node_4428 = (challenges[12usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (next_base_row[52usize]));
        let node_4433 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_ext_row[16usize]);
        let node_4479 = ((next_base_row[51usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64)))
            * (next_base_row[51usize]);
        let node_4553 = (next_ext_row[23usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[23usize]));
        let node_4532 = (next_base_row[57usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[57usize]));
        let node_5409 = (current_base_row[63usize])
            + (BFieldElement::from_raw_u64(18446743897615892521u64));
        let node_5411 = (current_base_row[64usize])
            + (BFieldElement::from_raw_u64(18446744047939747846u64));
        let node_5642 = (next_ext_row[24usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[24usize]));
        let node_4590 = (((((current_base_row[65usize])
            * (BFieldElement::from_raw_u64(18446744069414518785u64)))
            + ((current_base_row[66usize])
                * (BFieldElement::from_raw_u64(18446744069414584320u64))))
            + ((current_base_row[67usize])
                * (BFieldElement::from_raw_u64(281474976645120u64))))
            + (current_base_row[68usize])) * (BFieldElement::from_raw_u64(1u64));
        let node_4601 = (((((current_base_row[69usize])
            * (BFieldElement::from_raw_u64(18446744069414518785u64)))
            + ((current_base_row[70usize])
                * (BFieldElement::from_raw_u64(18446744069414584320u64))))
            + ((current_base_row[71usize])
                * (BFieldElement::from_raw_u64(281474976645120u64))))
            + (current_base_row[72usize])) * (BFieldElement::from_raw_u64(1u64));
        let node_4612 = (((((current_base_row[73usize])
            * (BFieldElement::from_raw_u64(18446744069414518785u64)))
            + ((current_base_row[74usize])
                * (BFieldElement::from_raw_u64(18446744069414584320u64))))
            + ((current_base_row[75usize])
                * (BFieldElement::from_raw_u64(281474976645120u64))))
            + (current_base_row[76usize])) * (BFieldElement::from_raw_u64(1u64));
        let node_4623 = (((((current_base_row[77usize])
            * (BFieldElement::from_raw_u64(18446744069414518785u64)))
            + ((current_base_row[78usize])
                * (BFieldElement::from_raw_u64(18446744069414584320u64))))
            + ((current_base_row[79usize])
                * (BFieldElement::from_raw_u64(281474976645120u64))))
            + (current_base_row[80usize])) * (BFieldElement::from_raw_u64(1u64));
        let node_5441 = (node_5411) * (node_5409);
        let node_5455 = ((current_base_row[62usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64)))
            * ((current_base_row[62usize])
                + (BFieldElement::from_raw_u64(18446744060824649731u64)));
        let node_5473 = (challenges[42usize])
            * ((next_base_row[103usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (current_base_row[103usize])));
        let node_5474 = (challenges[43usize])
            * ((next_base_row[104usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (current_base_row[104usize])));
        let node_5476 = (challenges[44usize])
            * ((next_base_row[105usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (current_base_row[105usize])));
        let node_5478 = (challenges[45usize])
            * ((next_base_row[106usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (current_base_row[106usize])));
        let node_5480 = (challenges[46usize])
            * ((next_base_row[107usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (current_base_row[107usize])));
        let node_5482 = (challenges[47usize])
            * ((next_base_row[108usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (current_base_row[108usize])));
        let node_5572 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (((((((((((challenges[32usize]) * (node_5306))
                + ((challenges[33usize]) * (node_5317)))
                + ((challenges[34usize]) * (node_5328)))
                + ((challenges[35usize]) * (node_5339)))
                + ((challenges[36usize]) * (next_base_row[97usize])))
                + ((challenges[37usize]) * (next_base_row[98usize])))
                + ((challenges[38usize]) * (next_base_row[99usize])))
                + ((challenges[39usize]) * (next_base_row[100usize])))
                + ((challenges[40usize]) * (next_base_row[101usize])))
                + ((challenges[41usize]) * (next_base_row[102usize])));
        let node_5549 = (next_ext_row[25usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[25usize]));
        let node_5558 = (((((challenges[32usize]) * (node_5306))
            + ((challenges[33usize]) * (node_5317)))
            + ((challenges[34usize]) * (node_5328)))
            + ((challenges[35usize]) * (node_5339)))
            + ((challenges[36usize]) * (next_base_row[97usize]));
        let node_5583 = (next_ext_row[26usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[26usize]));
        let node_5609 = (next_ext_row[27usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[27usize]));
        let node_5612 = (next_base_row[63usize])
            + (BFieldElement::from_raw_u64(18446743828896415801u64));
        let node_5956 = (next_ext_row[44usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[44usize]));
        let node_5972 = (next_ext_row[45usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[45usize]));
        let node_5967 = ((challenges[52usize]) * (next_base_row[131usize]))
            + ((challenges[53usize]) * (next_base_row[133usize]));
        let node_5970 = ((challenges[52usize]) * (next_base_row[130usize]))
            + ((challenges[53usize]) * (next_base_row[132usize]));
        let node_6010 = (next_ext_row[46usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[46usize]));
        let node_6066 = ((next_base_row[140usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[140usize])))
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_6072 = (node_6051)
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_6092 = (next_base_row[147usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_6094 = (next_base_row[147usize])
            + (BFieldElement::from_raw_u64(18446744060824649731u64));
        let node_6097 = (current_base_row[318usize]) * (next_base_row[147usize]);
        let node_6099 = (current_base_row[147usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_6064 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_base_row[140usize]);
        let node_6158 = (next_base_row[147usize]) * (next_base_row[147usize]);
        let node_6108 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (node_6051);
        let node_6174 = (next_ext_row[48usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[48usize]));
        let node_2330 = (current_base_row[12usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_2313 = (current_base_row[13usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_288 = (BFieldElement::from_raw_u64(4294967295u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[42usize]));
        let node_290 = (BFieldElement::from_raw_u64(4294967295u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[41usize]));
        let node_5484 = (next_base_row[64usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_5485 = (next_base_row[64usize])
            + (BFieldElement::from_raw_u64(18446744060824649731u64));
        let node_5487 = (next_base_row[64usize])
            + (BFieldElement::from_raw_u64(18446744056529682436u64));
        let node_6077 = (next_base_row[142usize])
            + (BFieldElement::from_raw_u64(18446744052234715141u64));
        let node_6079 = (next_base_row[142usize])
            + (BFieldElement::from_raw_u64(18446744009285042191u64));
        let node_133 = (current_base_row[40usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_5489 = (next_base_row[64usize])
            + (BFieldElement::from_raw_u64(18446744052234715141u64));
        let node_4039 = (next_base_row[12usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_4043 = (next_base_row[15usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_4054 = (next_base_row[16usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_5426 = (current_base_row[62usize])
            + (BFieldElement::from_raw_u64(18446744060824649731u64));
        let node_5448 = (current_base_row[62usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_281 = (challenges[7usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (((node_272) + ((challenges[18usize]) * (next_base_row[38usize])))
                    + ((challenges[19usize]) * (next_base_row[37usize]))));
        let node_564 = (challenges[7usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (((node_272) + ((challenges[18usize]) * (current_base_row[38usize])))
                    + ((challenges[19usize]) * (current_base_row[37usize]))));
        let node_1283 = (challenges[8usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (((node_1274)
                    + (((next_base_row[22usize])
                        + (BFieldElement::from_raw_u64(4294967295u64)))
                        * (challenges[21usize])))
                    + ((next_base_row[23usize]) * (challenges[22usize]))));
        let node_1511 = (challenges[8usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (((node_1272) + ((current_base_row[22usize]) * (challenges[21usize])))
                    + ((current_base_row[23usize]) * (challenges[22usize]))));
        let node_1533 = ((current_base_row[22usize])
            + (BFieldElement::from_raw_u64(4294967295u64))) * (challenges[21usize]);
        let node_1573 = ((current_base_row[22usize])
            + (BFieldElement::from_raw_u64(8589934590u64))) * (challenges[21usize]);
        let node_2153 = (current_base_row[39usize]) * (challenges[22usize]);
        let node_2216 = (challenges[8usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (((node_1274) + ((current_base_row[22usize]) * (challenges[21usize])))
                    + (node_2153)));
        let node_2228 = (node_1274)
            + ((current_base_row[23usize]) * (challenges[21usize]));
        let node_2234 = (node_1274)
            + (((current_base_row[23usize])
                + (BFieldElement::from_raw_u64(4294967295u64))) * (challenges[21usize]));
        let node_2240 = (node_1274)
            + (((current_base_row[23usize])
                + (BFieldElement::from_raw_u64(8589934590u64))) * (challenges[21usize]));
        let node_2180 = (current_base_row[43usize]) * (challenges[22usize]);
        let base_constraints = [
            (next_base_row[0usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[0usize])
                        + (BFieldElement::from_raw_u64(4294967295u64)))),
            (current_base_row[6usize])
                * ((next_base_row[6usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_base_row[6usize]))),
            ((node_34) * (next_base_row[3usize]))
                + ((current_base_row[4usize])
                    * (((next_base_row[3usize]) + (node_30))
                        + (BFieldElement::from_raw_u64(18446744065119617026u64)))),
            (current_base_row[5usize])
                * ((next_base_row[5usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))),
            (((current_base_row[5usize])
                + (BFieldElement::from_raw_u64(18446744065119617026u64)))
                * (next_base_row[5usize]))
                * ((next_base_row[1usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))),
            (current_base_row[5usize]) * (next_base_row[1usize]),
            ((current_base_row[5usize]) * (node_34)) * (node_47),
            ((next_base_row[7usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (current_base_row[7usize])))
                + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            (current_base_row[8usize])
                * ((next_base_row[8usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_base_row[8usize]))),
            ((((((((((((((((((current_base_row[205usize]) * (node_120))
                + ((current_base_row[206usize]) * (node_545)))
                + ((current_base_row[213usize]) * (node_1235)))
                + ((current_base_row[223usize]) * (node_1242)))
                + ((current_base_row[218usize])
                    * ((((((current_base_row[195usize]) * (node_541))
                        + ((current_base_row[196usize])
                            * ((next_base_row[30usize]) + (node_540))))
                        + ((current_base_row[197usize])
                            * ((next_base_row[31usize]) + (node_540))))
                        + ((current_base_row[198usize])
                            * ((next_base_row[32usize]) + (node_540))))
                        + ((current_base_row[199usize])
                            * ((next_base_row[33usize]) + (node_540))))))
                + ((current_base_row[224usize])
                    * ((((((current_base_row[195usize]) * (node_1235))
                        + ((current_base_row[196usize])
                            * ((next_base_row[28usize]) + (node_544))))
                        + ((current_base_row[197usize]) * (node_1588)))
                        + ((current_base_row[198usize])
                            * ((next_base_row[28usize]) + (node_548))))
                        + ((current_base_row[199usize]) * (node_1662)))))
                + ((current_base_row[228usize]) * (node_1243)))
                + ((current_base_row[229usize]) * (node_1243)))
                + ((current_base_row[235usize]) * (node_1241)))
                + ((current_base_row[237usize]) * (node_120)))
                + ((current_base_row[234usize]) * (node_262)))
                + ((current_base_row[238usize]) * (node_262)))
                + ((current_base_row[243usize]) * (node_262)))
                + ((current_base_row[250usize]) * (node_262)))
                + ((current_base_row[268usize]) * (node_1182)))
                + ((current_base_row[269usize]) * (node_1182)))
                + ((current_base_row[282usize]) * (node_124))) * (node_3926),
            (node_4336) * (node_4335),
            ((node_4336)
                * ((next_base_row[49usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_base_row[49usize])))) * (next_base_row[47usize]),
            ((current_base_row[47usize])
                * ((current_base_row[47usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                * (node_4342),
            (((current_base_row[51usize])
                + (BFieldElement::from_raw_u64(18446744065119617026u64)))
                * (current_base_row[51usize])) * (node_4405),
            (current_base_row[54usize]) * (node_4413),
            (node_4410) * (node_4413),
            ((node_4413)
                * ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (next_base_row[51usize])))
                * ((next_base_row[53usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_base_row[53usize]))),
            (node_4413)
                * ((next_base_row[55usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_base_row[55usize]))),
            (node_4413)
                * ((next_base_row[56usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_base_row[56usize]))),
            (node_4517) * (node_4516),
            (node_4524)
                * ((next_base_row[60usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_base_row[60usize]))),
            (node_4524)
                * ((next_base_row[61usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_base_row[61usize]))),
            (current_base_row[368usize])
                * ((current_base_row[58usize])
                    + (BFieldElement::from_raw_u64(18446743927680663586u64))),
            ((current_base_row[363usize])
                * ((current_base_row[64usize])
                    + (BFieldElement::from_raw_u64(18446744052234715141u64))))
                * (next_base_row[64usize]),
            (((next_base_row[62usize]) * (node_5409)) * (node_5411))
                * (((next_base_row[64usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_base_row[64usize])))
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))),
            (current_base_row[369usize]) * (node_5439),
            (node_5441)
                * ((next_base_row[63usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_base_row[63usize]))),
            (node_5441)
                * ((next_base_row[62usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_base_row[62usize]))),
            ((current_base_row[364usize]) * (node_5435)) * (next_base_row[62usize]),
            (current_base_row[370usize]) * (next_base_row[62usize]),
            ((node_5455) * (node_5427)) * (next_base_row[62usize]),
            (next_base_row[64usize])
                * (((((((((((((((((((BFieldElement::from_raw_u64(263719581847590u64))
                    * (node_4646))
                    + ((BFieldElement::from_raw_u64(76643691379275u64)) * (node_4657)))
                    + ((BFieldElement::from_raw_u64(115096533571410u64)) * (node_4668)))
                    + ((BFieldElement::from_raw_u64(256362302871255u64)) * (node_4679)))
                    + ((BFieldElement::from_raw_u64(51629801853195u64))
                        * (current_base_row[306usize])))
                    + ((BFieldElement::from_raw_u64(175668457332795u64))
                        * (current_base_row[307usize])))
                    + ((BFieldElement::from_raw_u64(177601192615545u64))
                        * (current_base_row[308usize])))
                    + ((BFieldElement::from_raw_u64(118201794925695u64))
                        * (current_base_row[309usize])))
                    + ((BFieldElement::from_raw_u64(244602682417545u64))
                        * (current_base_row[310usize])))
                    + ((BFieldElement::from_raw_u64(51685636428030u64))
                        * (current_base_row[311usize])))
                    + ((BFieldElement::from_raw_u64(231348413345175u64))
                        * (current_base_row[312usize])))
                    + ((BFieldElement::from_raw_u64(185731565704980u64))
                        * (current_base_row[313usize])))
                    + ((BFieldElement::from_raw_u64(32014686216930u64))
                        * (current_base_row[314usize])))
                    + ((BFieldElement::from_raw_u64(145268678818785u64))
                        * (current_base_row[315usize])))
                    + ((BFieldElement::from_raw_u64(123480309731250u64))
                        * (current_base_row[316usize])))
                    + ((BFieldElement::from_raw_u64(4758823762860u64))
                        * (current_base_row[317usize]))) + (current_base_row[113usize]))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (node_5306))),
            (next_base_row[64usize])
                * (((((((((((((((((((BFieldElement::from_raw_u64(4758823762860u64))
                    * (node_4646))
                    + ((BFieldElement::from_raw_u64(263719581847590u64)) * (node_4657)))
                    + ((BFieldElement::from_raw_u64(76643691379275u64)) * (node_4668)))
                    + ((BFieldElement::from_raw_u64(115096533571410u64)) * (node_4679)))
                    + ((BFieldElement::from_raw_u64(256362302871255u64))
                        * (current_base_row[306usize])))
                    + ((BFieldElement::from_raw_u64(51629801853195u64))
                        * (current_base_row[307usize])))
                    + ((BFieldElement::from_raw_u64(175668457332795u64))
                        * (current_base_row[308usize])))
                    + ((BFieldElement::from_raw_u64(177601192615545u64))
                        * (current_base_row[309usize])))
                    + ((BFieldElement::from_raw_u64(118201794925695u64))
                        * (current_base_row[310usize])))
                    + ((BFieldElement::from_raw_u64(244602682417545u64))
                        * (current_base_row[311usize])))
                    + ((BFieldElement::from_raw_u64(51685636428030u64))
                        * (current_base_row[312usize])))
                    + ((BFieldElement::from_raw_u64(231348413345175u64))
                        * (current_base_row[313usize])))
                    + ((BFieldElement::from_raw_u64(185731565704980u64))
                        * (current_base_row[314usize])))
                    + ((BFieldElement::from_raw_u64(32014686216930u64))
                        * (current_base_row[315usize])))
                    + ((BFieldElement::from_raw_u64(145268678818785u64))
                        * (current_base_row[316usize])))
                    + ((BFieldElement::from_raw_u64(123480309731250u64))
                        * (current_base_row[317usize]))) + (current_base_row[114usize]))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (node_5317))),
            (next_base_row[64usize])
                * (((((((((((((((((((BFieldElement::from_raw_u64(123480309731250u64))
                    * (node_4646))
                    + ((BFieldElement::from_raw_u64(4758823762860u64)) * (node_4657)))
                    + ((BFieldElement::from_raw_u64(263719581847590u64)) * (node_4668)))
                    + ((BFieldElement::from_raw_u64(76643691379275u64)) * (node_4679)))
                    + ((BFieldElement::from_raw_u64(115096533571410u64))
                        * (current_base_row[306usize])))
                    + ((BFieldElement::from_raw_u64(256362302871255u64))
                        * (current_base_row[307usize])))
                    + ((BFieldElement::from_raw_u64(51629801853195u64))
                        * (current_base_row[308usize])))
                    + ((BFieldElement::from_raw_u64(175668457332795u64))
                        * (current_base_row[309usize])))
                    + ((BFieldElement::from_raw_u64(177601192615545u64))
                        * (current_base_row[310usize])))
                    + ((BFieldElement::from_raw_u64(118201794925695u64))
                        * (current_base_row[311usize])))
                    + ((BFieldElement::from_raw_u64(244602682417545u64))
                        * (current_base_row[312usize])))
                    + ((BFieldElement::from_raw_u64(51685636428030u64))
                        * (current_base_row[313usize])))
                    + ((BFieldElement::from_raw_u64(231348413345175u64))
                        * (current_base_row[314usize])))
                    + ((BFieldElement::from_raw_u64(185731565704980u64))
                        * (current_base_row[315usize])))
                    + ((BFieldElement::from_raw_u64(32014686216930u64))
                        * (current_base_row[316usize])))
                    + ((BFieldElement::from_raw_u64(145268678818785u64))
                        * (current_base_row[317usize]))) + (current_base_row[115usize]))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (node_5328))),
            (next_base_row[64usize])
                * (((((((((((((((((((BFieldElement::from_raw_u64(145268678818785u64))
                    * (node_4646))
                    + ((BFieldElement::from_raw_u64(123480309731250u64)) * (node_4657)))
                    + ((BFieldElement::from_raw_u64(4758823762860u64)) * (node_4668)))
                    + ((BFieldElement::from_raw_u64(263719581847590u64)) * (node_4679)))
                    + ((BFieldElement::from_raw_u64(76643691379275u64))
                        * (current_base_row[306usize])))
                    + ((BFieldElement::from_raw_u64(115096533571410u64))
                        * (current_base_row[307usize])))
                    + ((BFieldElement::from_raw_u64(256362302871255u64))
                        * (current_base_row[308usize])))
                    + ((BFieldElement::from_raw_u64(51629801853195u64))
                        * (current_base_row[309usize])))
                    + ((BFieldElement::from_raw_u64(175668457332795u64))
                        * (current_base_row[310usize])))
                    + ((BFieldElement::from_raw_u64(177601192615545u64))
                        * (current_base_row[311usize])))
                    + ((BFieldElement::from_raw_u64(118201794925695u64))
                        * (current_base_row[312usize])))
                    + ((BFieldElement::from_raw_u64(244602682417545u64))
                        * (current_base_row[313usize])))
                    + ((BFieldElement::from_raw_u64(51685636428030u64))
                        * (current_base_row[314usize])))
                    + ((BFieldElement::from_raw_u64(231348413345175u64))
                        * (current_base_row[315usize])))
                    + ((BFieldElement::from_raw_u64(185731565704980u64))
                        * (current_base_row[316usize])))
                    + ((BFieldElement::from_raw_u64(32014686216930u64))
                        * (current_base_row[317usize]))) + (current_base_row[116usize]))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (node_5339))),
            (next_base_row[64usize])
                * (((((((((((((((((((BFieldElement::from_raw_u64(32014686216930u64))
                    * (node_4646))
                    + ((BFieldElement::from_raw_u64(145268678818785u64)) * (node_4657)))
                    + ((BFieldElement::from_raw_u64(123480309731250u64)) * (node_4668)))
                    + ((BFieldElement::from_raw_u64(4758823762860u64)) * (node_4679)))
                    + ((BFieldElement::from_raw_u64(263719581847590u64))
                        * (current_base_row[306usize])))
                    + ((BFieldElement::from_raw_u64(76643691379275u64))
                        * (current_base_row[307usize])))
                    + ((BFieldElement::from_raw_u64(115096533571410u64))
                        * (current_base_row[308usize])))
                    + ((BFieldElement::from_raw_u64(256362302871255u64))
                        * (current_base_row[309usize])))
                    + ((BFieldElement::from_raw_u64(51629801853195u64))
                        * (current_base_row[310usize])))
                    + ((BFieldElement::from_raw_u64(175668457332795u64))
                        * (current_base_row[311usize])))
                    + ((BFieldElement::from_raw_u64(177601192615545u64))
                        * (current_base_row[312usize])))
                    + ((BFieldElement::from_raw_u64(118201794925695u64))
                        * (current_base_row[313usize])))
                    + ((BFieldElement::from_raw_u64(244602682417545u64))
                        * (current_base_row[314usize])))
                    + ((BFieldElement::from_raw_u64(51685636428030u64))
                        * (current_base_row[315usize])))
                    + ((BFieldElement::from_raw_u64(231348413345175u64))
                        * (current_base_row[316usize])))
                    + ((BFieldElement::from_raw_u64(185731565704980u64))
                        * (current_base_row[317usize]))) + (current_base_row[117usize]))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (next_base_row[97usize]))),
            (next_base_row[64usize])
                * (((((((((((((((((((BFieldElement::from_raw_u64(185731565704980u64))
                    * (node_4646))
                    + ((BFieldElement::from_raw_u64(32014686216930u64)) * (node_4657)))
                    + ((BFieldElement::from_raw_u64(145268678818785u64)) * (node_4668)))
                    + ((BFieldElement::from_raw_u64(123480309731250u64)) * (node_4679)))
                    + ((BFieldElement::from_raw_u64(4758823762860u64))
                        * (current_base_row[306usize])))
                    + ((BFieldElement::from_raw_u64(263719581847590u64))
                        * (current_base_row[307usize])))
                    + ((BFieldElement::from_raw_u64(76643691379275u64))
                        * (current_base_row[308usize])))
                    + ((BFieldElement::from_raw_u64(115096533571410u64))
                        * (current_base_row[309usize])))
                    + ((BFieldElement::from_raw_u64(256362302871255u64))
                        * (current_base_row[310usize])))
                    + ((BFieldElement::from_raw_u64(51629801853195u64))
                        * (current_base_row[311usize])))
                    + ((BFieldElement::from_raw_u64(175668457332795u64))
                        * (current_base_row[312usize])))
                    + ((BFieldElement::from_raw_u64(177601192615545u64))
                        * (current_base_row[313usize])))
                    + ((BFieldElement::from_raw_u64(118201794925695u64))
                        * (current_base_row[314usize])))
                    + ((BFieldElement::from_raw_u64(244602682417545u64))
                        * (current_base_row[315usize])))
                    + ((BFieldElement::from_raw_u64(51685636428030u64))
                        * (current_base_row[316usize])))
                    + ((BFieldElement::from_raw_u64(231348413345175u64))
                        * (current_base_row[317usize]))) + (current_base_row[118usize]))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (next_base_row[98usize]))),
            (next_base_row[64usize])
                * (((((((((((((((((((BFieldElement::from_raw_u64(231348413345175u64))
                    * (node_4646))
                    + ((BFieldElement::from_raw_u64(185731565704980u64)) * (node_4657)))
                    + ((BFieldElement::from_raw_u64(32014686216930u64)) * (node_4668)))
                    + ((BFieldElement::from_raw_u64(145268678818785u64)) * (node_4679)))
                    + ((BFieldElement::from_raw_u64(123480309731250u64))
                        * (current_base_row[306usize])))
                    + ((BFieldElement::from_raw_u64(4758823762860u64))
                        * (current_base_row[307usize])))
                    + ((BFieldElement::from_raw_u64(263719581847590u64))
                        * (current_base_row[308usize])))
                    + ((BFieldElement::from_raw_u64(76643691379275u64))
                        * (current_base_row[309usize])))
                    + ((BFieldElement::from_raw_u64(115096533571410u64))
                        * (current_base_row[310usize])))
                    + ((BFieldElement::from_raw_u64(256362302871255u64))
                        * (current_base_row[311usize])))
                    + ((BFieldElement::from_raw_u64(51629801853195u64))
                        * (current_base_row[312usize])))
                    + ((BFieldElement::from_raw_u64(175668457332795u64))
                        * (current_base_row[313usize])))
                    + ((BFieldElement::from_raw_u64(177601192615545u64))
                        * (current_base_row[314usize])))
                    + ((BFieldElement::from_raw_u64(118201794925695u64))
                        * (current_base_row[315usize])))
                    + ((BFieldElement::from_raw_u64(244602682417545u64))
                        * (current_base_row[316usize])))
                    + ((BFieldElement::from_raw_u64(51685636428030u64))
                        * (current_base_row[317usize]))) + (current_base_row[119usize]))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (next_base_row[99usize]))),
            (next_base_row[64usize])
                * (((((((((((((((((((BFieldElement::from_raw_u64(51685636428030u64))
                    * (node_4646))
                    + ((BFieldElement::from_raw_u64(231348413345175u64)) * (node_4657)))
                    + ((BFieldElement::from_raw_u64(185731565704980u64)) * (node_4668)))
                    + ((BFieldElement::from_raw_u64(32014686216930u64)) * (node_4679)))
                    + ((BFieldElement::from_raw_u64(145268678818785u64))
                        * (current_base_row[306usize])))
                    + ((BFieldElement::from_raw_u64(123480309731250u64))
                        * (current_base_row[307usize])))
                    + ((BFieldElement::from_raw_u64(4758823762860u64))
                        * (current_base_row[308usize])))
                    + ((BFieldElement::from_raw_u64(263719581847590u64))
                        * (current_base_row[309usize])))
                    + ((BFieldElement::from_raw_u64(76643691379275u64))
                        * (current_base_row[310usize])))
                    + ((BFieldElement::from_raw_u64(115096533571410u64))
                        * (current_base_row[311usize])))
                    + ((BFieldElement::from_raw_u64(256362302871255u64))
                        * (current_base_row[312usize])))
                    + ((BFieldElement::from_raw_u64(51629801853195u64))
                        * (current_base_row[313usize])))
                    + ((BFieldElement::from_raw_u64(175668457332795u64))
                        * (current_base_row[314usize])))
                    + ((BFieldElement::from_raw_u64(177601192615545u64))
                        * (current_base_row[315usize])))
                    + ((BFieldElement::from_raw_u64(118201794925695u64))
                        * (current_base_row[316usize])))
                    + ((BFieldElement::from_raw_u64(244602682417545u64))
                        * (current_base_row[317usize]))) + (current_base_row[120usize]))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (next_base_row[100usize]))),
            (next_base_row[64usize])
                * (((((((((((((((((((BFieldElement::from_raw_u64(244602682417545u64))
                    * (node_4646))
                    + ((BFieldElement::from_raw_u64(51685636428030u64)) * (node_4657)))
                    + ((BFieldElement::from_raw_u64(231348413345175u64)) * (node_4668)))
                    + ((BFieldElement::from_raw_u64(185731565704980u64)) * (node_4679)))
                    + ((BFieldElement::from_raw_u64(32014686216930u64))
                        * (current_base_row[306usize])))
                    + ((BFieldElement::from_raw_u64(145268678818785u64))
                        * (current_base_row[307usize])))
                    + ((BFieldElement::from_raw_u64(123480309731250u64))
                        * (current_base_row[308usize])))
                    + ((BFieldElement::from_raw_u64(4758823762860u64))
                        * (current_base_row[309usize])))
                    + ((BFieldElement::from_raw_u64(263719581847590u64))
                        * (current_base_row[310usize])))
                    + ((BFieldElement::from_raw_u64(76643691379275u64))
                        * (current_base_row[311usize])))
                    + ((BFieldElement::from_raw_u64(115096533571410u64))
                        * (current_base_row[312usize])))
                    + ((BFieldElement::from_raw_u64(256362302871255u64))
                        * (current_base_row[313usize])))
                    + ((BFieldElement::from_raw_u64(51629801853195u64))
                        * (current_base_row[314usize])))
                    + ((BFieldElement::from_raw_u64(175668457332795u64))
                        * (current_base_row[315usize])))
                    + ((BFieldElement::from_raw_u64(177601192615545u64))
                        * (current_base_row[316usize])))
                    + ((BFieldElement::from_raw_u64(118201794925695u64))
                        * (current_base_row[317usize]))) + (current_base_row[121usize]))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (next_base_row[101usize]))),
            (next_base_row[64usize])
                * (((((((((((((((((((BFieldElement::from_raw_u64(118201794925695u64))
                    * (node_4646))
                    + ((BFieldElement::from_raw_u64(244602682417545u64)) * (node_4657)))
                    + ((BFieldElement::from_raw_u64(51685636428030u64)) * (node_4668)))
                    + ((BFieldElement::from_raw_u64(231348413345175u64)) * (node_4679)))
                    + ((BFieldElement::from_raw_u64(185731565704980u64))
                        * (current_base_row[306usize])))
                    + ((BFieldElement::from_raw_u64(32014686216930u64))
                        * (current_base_row[307usize])))
                    + ((BFieldElement::from_raw_u64(145268678818785u64))
                        * (current_base_row[308usize])))
                    + ((BFieldElement::from_raw_u64(123480309731250u64))
                        * (current_base_row[309usize])))
                    + ((BFieldElement::from_raw_u64(4758823762860u64))
                        * (current_base_row[310usize])))
                    + ((BFieldElement::from_raw_u64(263719581847590u64))
                        * (current_base_row[311usize])))
                    + ((BFieldElement::from_raw_u64(76643691379275u64))
                        * (current_base_row[312usize])))
                    + ((BFieldElement::from_raw_u64(115096533571410u64))
                        * (current_base_row[313usize])))
                    + ((BFieldElement::from_raw_u64(256362302871255u64))
                        * (current_base_row[314usize])))
                    + ((BFieldElement::from_raw_u64(51629801853195u64))
                        * (current_base_row[315usize])))
                    + ((BFieldElement::from_raw_u64(175668457332795u64))
                        * (current_base_row[316usize])))
                    + ((BFieldElement::from_raw_u64(177601192615545u64))
                        * (current_base_row[317usize]))) + (current_base_row[122usize]))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (next_base_row[102usize]))),
            (next_base_row[64usize])
                * (((((((((((((((((((BFieldElement::from_raw_u64(177601192615545u64))
                    * (node_4646))
                    + ((BFieldElement::from_raw_u64(118201794925695u64)) * (node_4657)))
                    + ((BFieldElement::from_raw_u64(244602682417545u64)) * (node_4668)))
                    + ((BFieldElement::from_raw_u64(51685636428030u64)) * (node_4679)))
                    + ((BFieldElement::from_raw_u64(231348413345175u64))
                        * (current_base_row[306usize])))
                    + ((BFieldElement::from_raw_u64(185731565704980u64))
                        * (current_base_row[307usize])))
                    + ((BFieldElement::from_raw_u64(32014686216930u64))
                        * (current_base_row[308usize])))
                    + ((BFieldElement::from_raw_u64(145268678818785u64))
                        * (current_base_row[309usize])))
                    + ((BFieldElement::from_raw_u64(123480309731250u64))
                        * (current_base_row[310usize])))
                    + ((BFieldElement::from_raw_u64(4758823762860u64))
                        * (current_base_row[311usize])))
                    + ((BFieldElement::from_raw_u64(263719581847590u64))
                        * (current_base_row[312usize])))
                    + ((BFieldElement::from_raw_u64(76643691379275u64))
                        * (current_base_row[313usize])))
                    + ((BFieldElement::from_raw_u64(115096533571410u64))
                        * (current_base_row[314usize])))
                    + ((BFieldElement::from_raw_u64(256362302871255u64))
                        * (current_base_row[315usize])))
                    + ((BFieldElement::from_raw_u64(51629801853195u64))
                        * (current_base_row[316usize])))
                    + ((BFieldElement::from_raw_u64(175668457332795u64))
                        * (current_base_row[317usize]))) + (current_base_row[123usize]))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (next_base_row[103usize]))),
            (next_base_row[64usize])
                * (((((((((((((((((((BFieldElement::from_raw_u64(175668457332795u64))
                    * (node_4646))
                    + ((BFieldElement::from_raw_u64(177601192615545u64)) * (node_4657)))
                    + ((BFieldElement::from_raw_u64(118201794925695u64)) * (node_4668)))
                    + ((BFieldElement::from_raw_u64(244602682417545u64)) * (node_4679)))
                    + ((BFieldElement::from_raw_u64(51685636428030u64))
                        * (current_base_row[306usize])))
                    + ((BFieldElement::from_raw_u64(231348413345175u64))
                        * (current_base_row[307usize])))
                    + ((BFieldElement::from_raw_u64(185731565704980u64))
                        * (current_base_row[308usize])))
                    + ((BFieldElement::from_raw_u64(32014686216930u64))
                        * (current_base_row[309usize])))
                    + ((BFieldElement::from_raw_u64(145268678818785u64))
                        * (current_base_row[310usize])))
                    + ((BFieldElement::from_raw_u64(123480309731250u64))
                        * (current_base_row[311usize])))
                    + ((BFieldElement::from_raw_u64(4758823762860u64))
                        * (current_base_row[312usize])))
                    + ((BFieldElement::from_raw_u64(263719581847590u64))
                        * (current_base_row[313usize])))
                    + ((BFieldElement::from_raw_u64(76643691379275u64))
                        * (current_base_row[314usize])))
                    + ((BFieldElement::from_raw_u64(115096533571410u64))
                        * (current_base_row[315usize])))
                    + ((BFieldElement::from_raw_u64(256362302871255u64))
                        * (current_base_row[316usize])))
                    + ((BFieldElement::from_raw_u64(51629801853195u64))
                        * (current_base_row[317usize]))) + (current_base_row[124usize]))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (next_base_row[104usize]))),
            (next_base_row[64usize])
                * (((((((((((((((((((BFieldElement::from_raw_u64(51629801853195u64))
                    * (node_4646))
                    + ((BFieldElement::from_raw_u64(175668457332795u64)) * (node_4657)))
                    + ((BFieldElement::from_raw_u64(177601192615545u64)) * (node_4668)))
                    + ((BFieldElement::from_raw_u64(118201794925695u64)) * (node_4679)))
                    + ((BFieldElement::from_raw_u64(244602682417545u64))
                        * (current_base_row[306usize])))
                    + ((BFieldElement::from_raw_u64(51685636428030u64))
                        * (current_base_row[307usize])))
                    + ((BFieldElement::from_raw_u64(231348413345175u64))
                        * (current_base_row[308usize])))
                    + ((BFieldElement::from_raw_u64(185731565704980u64))
                        * (current_base_row[309usize])))
                    + ((BFieldElement::from_raw_u64(32014686216930u64))
                        * (current_base_row[310usize])))
                    + ((BFieldElement::from_raw_u64(145268678818785u64))
                        * (current_base_row[311usize])))
                    + ((BFieldElement::from_raw_u64(123480309731250u64))
                        * (current_base_row[312usize])))
                    + ((BFieldElement::from_raw_u64(4758823762860u64))
                        * (current_base_row[313usize])))
                    + ((BFieldElement::from_raw_u64(263719581847590u64))
                        * (current_base_row[314usize])))
                    + ((BFieldElement::from_raw_u64(76643691379275u64))
                        * (current_base_row[315usize])))
                    + ((BFieldElement::from_raw_u64(115096533571410u64))
                        * (current_base_row[316usize])))
                    + ((BFieldElement::from_raw_u64(256362302871255u64))
                        * (current_base_row[317usize]))) + (current_base_row[125usize]))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (next_base_row[105usize]))),
            (next_base_row[64usize])
                * (((((((((((((((((((BFieldElement::from_raw_u64(256362302871255u64))
                    * (node_4646))
                    + ((BFieldElement::from_raw_u64(51629801853195u64)) * (node_4657)))
                    + ((BFieldElement::from_raw_u64(175668457332795u64)) * (node_4668)))
                    + ((BFieldElement::from_raw_u64(177601192615545u64)) * (node_4679)))
                    + ((BFieldElement::from_raw_u64(118201794925695u64))
                        * (current_base_row[306usize])))
                    + ((BFieldElement::from_raw_u64(244602682417545u64))
                        * (current_base_row[307usize])))
                    + ((BFieldElement::from_raw_u64(51685636428030u64))
                        * (current_base_row[308usize])))
                    + ((BFieldElement::from_raw_u64(231348413345175u64))
                        * (current_base_row[309usize])))
                    + ((BFieldElement::from_raw_u64(185731565704980u64))
                        * (current_base_row[310usize])))
                    + ((BFieldElement::from_raw_u64(32014686216930u64))
                        * (current_base_row[311usize])))
                    + ((BFieldElement::from_raw_u64(145268678818785u64))
                        * (current_base_row[312usize])))
                    + ((BFieldElement::from_raw_u64(123480309731250u64))
                        * (current_base_row[313usize])))
                    + ((BFieldElement::from_raw_u64(4758823762860u64))
                        * (current_base_row[314usize])))
                    + ((BFieldElement::from_raw_u64(263719581847590u64))
                        * (current_base_row[315usize])))
                    + ((BFieldElement::from_raw_u64(76643691379275u64))
                        * (current_base_row[316usize])))
                    + ((BFieldElement::from_raw_u64(115096533571410u64))
                        * (current_base_row[317usize]))) + (current_base_row[126usize]))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (next_base_row[106usize]))),
            (next_base_row[64usize])
                * (((((((((((((((((((BFieldElement::from_raw_u64(115096533571410u64))
                    * (node_4646))
                    + ((BFieldElement::from_raw_u64(256362302871255u64)) * (node_4657)))
                    + ((BFieldElement::from_raw_u64(51629801853195u64)) * (node_4668)))
                    + ((BFieldElement::from_raw_u64(175668457332795u64)) * (node_4679)))
                    + ((BFieldElement::from_raw_u64(177601192615545u64))
                        * (current_base_row[306usize])))
                    + ((BFieldElement::from_raw_u64(118201794925695u64))
                        * (current_base_row[307usize])))
                    + ((BFieldElement::from_raw_u64(244602682417545u64))
                        * (current_base_row[308usize])))
                    + ((BFieldElement::from_raw_u64(51685636428030u64))
                        * (current_base_row[309usize])))
                    + ((BFieldElement::from_raw_u64(231348413345175u64))
                        * (current_base_row[310usize])))
                    + ((BFieldElement::from_raw_u64(185731565704980u64))
                        * (current_base_row[311usize])))
                    + ((BFieldElement::from_raw_u64(32014686216930u64))
                        * (current_base_row[312usize])))
                    + ((BFieldElement::from_raw_u64(145268678818785u64))
                        * (current_base_row[313usize])))
                    + ((BFieldElement::from_raw_u64(123480309731250u64))
                        * (current_base_row[314usize])))
                    + ((BFieldElement::from_raw_u64(4758823762860u64))
                        * (current_base_row[315usize])))
                    + ((BFieldElement::from_raw_u64(263719581847590u64))
                        * (current_base_row[316usize])))
                    + ((BFieldElement::from_raw_u64(76643691379275u64))
                        * (current_base_row[317usize]))) + (current_base_row[127usize]))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (next_base_row[107usize]))),
            (next_base_row[64usize])
                * (((((((((((((((((((BFieldElement::from_raw_u64(76643691379275u64))
                    * (node_4646))
                    + ((BFieldElement::from_raw_u64(115096533571410u64)) * (node_4657)))
                    + ((BFieldElement::from_raw_u64(256362302871255u64)) * (node_4668)))
                    + ((BFieldElement::from_raw_u64(51629801853195u64)) * (node_4679)))
                    + ((BFieldElement::from_raw_u64(175668457332795u64))
                        * (current_base_row[306usize])))
                    + ((BFieldElement::from_raw_u64(177601192615545u64))
                        * (current_base_row[307usize])))
                    + ((BFieldElement::from_raw_u64(118201794925695u64))
                        * (current_base_row[308usize])))
                    + ((BFieldElement::from_raw_u64(244602682417545u64))
                        * (current_base_row[309usize])))
                    + ((BFieldElement::from_raw_u64(51685636428030u64))
                        * (current_base_row[310usize])))
                    + ((BFieldElement::from_raw_u64(231348413345175u64))
                        * (current_base_row[311usize])))
                    + ((BFieldElement::from_raw_u64(185731565704980u64))
                        * (current_base_row[312usize])))
                    + ((BFieldElement::from_raw_u64(32014686216930u64))
                        * (current_base_row[313usize])))
                    + ((BFieldElement::from_raw_u64(145268678818785u64))
                        * (current_base_row[314usize])))
                    + ((BFieldElement::from_raw_u64(123480309731250u64))
                        * (current_base_row[315usize])))
                    + ((BFieldElement::from_raw_u64(4758823762860u64))
                        * (current_base_row[316usize])))
                    + ((BFieldElement::from_raw_u64(263719581847590u64))
                        * (current_base_row[317usize]))) + (current_base_row[128usize]))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (next_base_row[108usize]))),
            (current_base_row[129usize]) * (node_5946),
            (current_base_row[135usize]) * (node_5998),
            ((next_base_row[135usize]) * (next_base_row[136usize]))
                + ((node_5998)
                    * (((next_base_row[136usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (current_base_row[136usize])))
                        + (BFieldElement::from_raw_u64(18446744065119617026u64)))),
            ((next_base_row[139usize]) * (current_base_row[143usize])) * (node_6048),
            (next_base_row[139usize]) * (current_base_row[145usize]),
            (node_6058)
                * ((next_base_row[142usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_base_row[142usize]))),
            (((node_6058) * (current_base_row[143usize])) * (node_6048)) * (node_6066),
            ((node_6058) * (current_base_row[145usize])) * (node_6066),
            (((node_6058) * (node_6048)) * (node_6051)) * (node_6072),
            ((node_6058) * (node_6054)) * (node_6075),
            (((current_base_row[318usize]) * (node_6092)) * (node_6094))
                * (current_base_row[147usize]),
            ((node_6097) * (node_6094)) * (node_6099),
            (((current_base_row[324usize]) * (node_6072)) * (node_6054)) * (node_6099),
            (((current_base_row[324usize]) * (node_6051)) * (node_6075))
                * (current_base_row[147usize]),
            ((current_base_row[366usize])
                * ((current_base_row[139usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                * ((current_base_row[147usize])
                    + (BFieldElement::from_raw_u64(18446744060824649731u64))),
            ((current_base_row[366usize]) * (current_base_row[139usize]))
                * (current_base_row[147usize]),
            ((node_6058) * (current_base_row[365usize]))
                * (((current_base_row[147usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((BFieldElement::from_raw_u64(8589934590u64))
                            * (next_base_row[147usize]))))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((node_6051) * (node_6054)))),
            (current_base_row[373usize]) * ((current_base_row[147usize]) + (node_6064)),
            ((current_base_row[331usize]) * (next_base_row[143usize]))
                * ((next_base_row[147usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_base_row[147usize]))),
            (current_base_row[367usize])
                * ((next_base_row[143usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_base_row[143usize]))),
            ((current_base_row[367usize]) * (node_6075))
                * ((current_base_row[147usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (node_6158))),
            ((current_base_row[367usize]) * (node_6054))
                * ((current_base_row[147usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_base_row[374usize]))),
            ((node_6058) * ((current_base_row[329usize]) * (node_6085)))
                * (((current_base_row[147usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (next_base_row[147usize]))) + (node_6108)),
            (current_base_row[169usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_2330) * (current_base_row[13usize]))),
            (current_base_row[170usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[169usize]) * (node_2303))),
            (current_base_row[171usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_2330) * (node_2313))),
            (current_base_row[172usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[12usize]) * (node_2313)) * (node_2303))),
            (current_base_row[173usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_288) * (node_290))),
            (current_base_row[174usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[171usize]) * (node_2303))),
            (current_base_row[175usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_288) * (current_base_row[41usize]))),
            (current_base_row[176usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[170usize]) * (node_2305))),
            (current_base_row[177usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[172usize]) * (node_2305))),
            (current_base_row[178usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[170usize]) * (current_base_row[15usize]))),
            (current_base_row[179usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[173usize]) * (current_base_row[40usize]))),
            (current_base_row[180usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[172usize]) * (current_base_row[15usize]))),
            (current_base_row[181usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[175usize]) * (node_293))),
            (current_base_row[182usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[174usize]) * (node_2305))),
            (current_base_row[183usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[174usize]) * (current_base_row[15usize]))),
            (current_base_row[184usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[12usize]) * (current_base_row[13usize]))
                        * (node_2303))),
            (current_base_row[185usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[169usize]) * (current_base_row[14usize]))),
            (current_base_row[186usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[178usize]) * (node_2307))),
            (current_base_row[187usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[180usize]) * (node_2307))),
            (current_base_row[188usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[176usize]) * (node_2307))),
            (current_base_row[189usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[177usize]) * (node_2307))),
            (current_base_row[190usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[173usize]) * (node_293))),
            (current_base_row[191usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[171usize]) * (current_base_row[14usize]))),
            (current_base_row[192usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[182usize]) * (node_2307))),
            (current_base_row[193usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[177usize]) * (current_base_row[16usize]))),
            (current_base_row[194usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[176usize]) * (current_base_row[16usize]))),
            (current_base_row[195usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[190usize]) * (current_base_row[39usize]))),
            (current_base_row[196usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[179usize]) * (node_341))),
            (current_base_row[197usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[179usize]) * (current_base_row[39usize]))),
            (current_base_row[198usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[181usize]) * (node_341))),
            (current_base_row[199usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[181usize]) * (current_base_row[39usize]))),
            (current_base_row[200usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[188usize]) * (node_2309))),
            (current_base_row[201usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[183usize]) * (node_2307))),
            (current_base_row[202usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[178usize]) * (current_base_row[16usize]))),
            (current_base_row[203usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[186usize]) * (node_2309))),
            (current_base_row[204usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[184usize]) * (node_2305))),
            (current_base_row[205usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[189usize]) * (node_2309)) * (node_2311))),
            (current_base_row[206usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[193usize]) * (node_2309)) * (node_2311))),
            (current_base_row[207usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[42usize]) * (node_290))),
            (current_base_row[208usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[183usize]) * (current_base_row[16usize]))),
            (current_base_row[209usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[180usize]) * (current_base_row[16usize]))),
            (current_base_row[210usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[42usize]) * (current_base_row[41usize]))),
            (current_base_row[211usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[192usize]) * (node_2309))),
            (current_base_row[212usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[185usize]) * (node_2305))),
            (current_base_row[213usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[200usize]) * (node_2311))),
            (current_base_row[214usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[182usize]) * (current_base_row[16usize]))),
            (current_base_row[215usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[191usize]) * (node_2305))),
            (current_base_row[216usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[204usize]) * (node_2307)) * (node_2309))
                        * (node_2311))),
            (current_base_row[217usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[185usize]) * (current_base_row[15usize]))),
            (current_base_row[218usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[187usize]) * (current_base_row[17usize]))
                        * (node_2311))),
            (current_base_row[219usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[184usize]) * (current_base_row[15usize]))
                        * (node_2307)) * (node_2309))),
            (current_base_row[220usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[187usize]) * (node_2309)) * (node_2311))),
            (current_base_row[221usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[194usize]) * (node_2309))),
            (current_base_row[222usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[201usize]) * (node_2309))),
            (current_base_row[223usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[203usize]) * (node_2311))),
            (current_base_row[224usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[219usize]) * (node_2311))),
            (current_base_row[225usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[209usize]) * (node_2309)) * (node_2311))),
            (current_base_row[226usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[215usize]) * (node_2307))),
            (current_base_row[227usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[191usize]) * (current_base_row[15usize]))),
            (current_base_row[228usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[186usize]) * (current_base_row[17usize]))
                        * (node_2311))),
            (current_base_row[229usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[194usize]) * (current_base_row[17usize]))
                        * (node_2311))),
            (current_base_row[230usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[221usize]) * (node_2311))),
            (current_base_row[231usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[208usize]) * (node_2309))),
            (current_base_row[232usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[202usize]) * (node_2309)) * (node_2311))),
            (current_base_row[233usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[211usize]) * (node_2311))),
            (current_base_row[234usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[212usize]) * (node_2307)) * (node_2309))
                        * (node_2311))),
            (current_base_row[235usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[202usize]) * (current_base_row[17usize]))
                        * (node_2311))),
            (current_base_row[236usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[222usize]) * (node_2311))),
            (current_base_row[237usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[226usize]) * (node_2309)) * (node_2311))),
            (current_base_row[238usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[217usize]) * (node_2307)) * (node_2309))
                        * (node_2311))),
            (current_base_row[239usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[214usize]) * (node_2309))),
            (current_base_row[240usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[189usize]) * (current_base_row[17usize]))
                        * (node_2311))),
            (current_base_row[241usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[231usize]) * (node_2311))),
            (current_base_row[242usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[192usize]) * (current_base_row[17usize]))
                        * (node_2311))),
            (current_base_row[243usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[212usize]) * (current_base_row[16usize]))
                        * (node_2309)) * (node_2311))),
            (current_base_row[244usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[175usize]) * (current_base_row[40usize]))),
            (current_base_row[245usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[207usize]) * (node_293))),
            (current_base_row[246usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[207usize]) * (current_base_row[40usize]))),
            (current_base_row[247usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[210usize]) * (node_293))),
            (current_base_row[248usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[210usize]) * (current_base_row[40usize]))),
            (current_base_row[249usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[41usize])
                        * ((current_base_row[41usize])
                            + (BFieldElement::from_raw_u64(18446744065119617026u64))))),
            (current_base_row[250usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[217usize]) * (current_base_row[16usize]))
                        * (node_2309)) * (node_2311))),
            (current_base_row[251usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[97usize]) * (current_base_row[97usize]))
                        * (current_base_row[97usize])) * (current_base_row[97usize]))),
            (current_base_row[252usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[227usize]) * (node_2307))),
            (current_base_row[253usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[98usize]) * (current_base_row[98usize]))
                        * (current_base_row[98usize])) * (current_base_row[98usize]))),
            (current_base_row[254usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[42usize])
                        * ((current_base_row[42usize])
                            + (BFieldElement::from_raw_u64(18446744065119617026u64))))),
            (current_base_row[255usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[99usize]) * (current_base_row[99usize]))
                        * (current_base_row[99usize])) * (current_base_row[99usize]))),
            (current_base_row[256usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[100usize]) * (current_base_row[100usize]))
                        * (current_base_row[100usize])) * (current_base_row[100usize]))),
            (current_base_row[257usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[201usize]) * (current_base_row[17usize]))
                        * (node_2311))),
            (current_base_row[258usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[188usize]) * (current_base_row[17usize]))
                        * (node_2311))),
            (current_base_row[259usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[101usize]) * (current_base_row[101usize]))
                        * (current_base_row[101usize])) * (current_base_row[101usize]))),
            (current_base_row[260usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[214usize]) * (current_base_row[17usize]))
                        * (node_2311))),
            (current_base_row[261usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[193usize]) * (current_base_row[17usize]))
                        * (node_2311))),
            (current_base_row[262usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[208usize]) * (current_base_row[17usize]))
                        * (node_2311))),
            (current_base_row[263usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[211usize]) * (current_base_row[18usize]))),
            (current_base_row[264usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[102usize]) * (current_base_row[102usize]))
                        * (current_base_row[102usize])) * (current_base_row[102usize]))),
            (current_base_row[265usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[239usize]) * (node_2311))),
            (current_base_row[266usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[215usize]) * (current_base_row[16usize]))
                        * (node_2309)) * (node_2311))),
            (current_base_row[267usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[103usize]) * (current_base_row[103usize]))
                        * (current_base_row[103usize])) * (current_base_row[103usize]))),
            (current_base_row[268usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[200usize]) * (current_base_row[18usize]))),
            (current_base_row[269usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[203usize]) * (current_base_row[18usize]))),
            (current_base_row[270usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[252usize]) * (node_2309)) * (node_2311))),
            (current_base_row[271usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[39usize]) * (node_1252))),
            (current_base_row[272usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[104usize]) * (current_base_row[104usize]))
                        * (current_base_row[104usize])) * (current_base_row[104usize]))),
            (current_base_row[273usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[227usize]) * (current_base_row[16usize]))
                        * (node_2309)) * (node_2311))),
            (current_base_row[274usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[105usize]) * (current_base_row[105usize]))
                        * (current_base_row[105usize])) * (current_base_row[105usize]))),
            (current_base_row[275usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[209usize]) * (current_base_row[17usize]))
                        * (node_2311))),
            (current_base_row[276usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[204usize]) * (current_base_row[16usize]))
                        * (node_2309)) * (node_2311))),
            (current_base_row[277usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[106usize]) * (current_base_row[106usize]))
                        * (current_base_row[106usize])) * (current_base_row[106usize]))),
            (current_base_row[278usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[107usize]) * (current_base_row[107usize]))
                        * (current_base_row[107usize])) * (current_base_row[107usize]))),
            (current_base_row[279usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[39usize]) * (current_base_row[22usize]))),
            (current_base_row[280usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[108usize]) * (current_base_row[108usize]))
                        * (current_base_row[108usize])) * (current_base_row[108usize]))),
            (current_base_row[281usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[222usize]) * (current_base_row[18usize]))),
            (current_base_row[282usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[221usize]) * (current_base_row[18usize]))),
            (current_base_row[283usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[190usize]) * (node_341))),
            (current_base_row[284usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[244usize]) * (node_341))),
            (current_base_row[285usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[244usize]) * (current_base_row[39usize]))),
            (current_base_row[286usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[245usize]) * (node_341))),
            (current_base_row[287usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[245usize]) * (current_base_row[39usize]))),
            (current_base_row[288usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[246usize]) * (node_341))),
            (current_base_row[289usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[246usize]) * (current_base_row[39usize]))),
            (current_base_row[290usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[247usize]) * (node_341))),
            (current_base_row[291usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[247usize]) * (current_base_row[39usize]))),
            (current_base_row[292usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[248usize]) * (node_341))),
            (current_base_row[293usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[248usize]) * (current_base_row[39usize]))),
            (current_base_row[294usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((next_base_row[64usize]) * (node_5484)) * (node_5485))
                        * (node_5487))),
            (current_base_row[295usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[44usize])
                        * ((current_base_row[44usize])
                            + (BFieldElement::from_raw_u64(18446744065119617026u64))))),
            (current_base_row[296usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((next_base_row[62usize]) * (node_5491)) * (node_5439))),
            (current_base_row[297usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[252usize]) * (current_base_row[17usize]))
                        * (node_2311))),
            (current_base_row[298usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[226usize]) * (current_base_row[17usize]))
                        * (node_2311))),
            (current_base_row[299usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[43usize])
                        * ((current_base_row[43usize])
                            + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                        * ((current_base_row[43usize])
                            + (BFieldElement::from_raw_u64(18446744060824649731u64))))
                        * ((current_base_row[43usize])
                            + (BFieldElement::from_raw_u64(18446744056529682436u64))))),
            (current_base_row[300usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[239usize]) * (current_base_row[18usize]))),
            (current_base_row[301usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[231usize]) * (current_base_row[18usize]))),
            (current_base_row[302usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((node_6077) * (node_6079)) * (node_6083)) * (node_6085))),
            (current_base_row[303usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[40usize]) * (node_133))),
            (current_base_row[304usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_6077)
                        * ((next_base_row[142usize])
                            + (BFieldElement::from_raw_u64(18446744043644780551u64))))),
            (current_base_row[305usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((node_5484) * (node_5485)) * (node_5487)) * (node_5489))),
            (current_base_row[306usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[251usize]) * (current_base_row[97usize]))
                        * (current_base_row[97usize])) * (current_base_row[97usize]))),
            (current_base_row[307usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[253usize]) * (current_base_row[98usize]))
                        * (current_base_row[98usize])) * (current_base_row[98usize]))),
            (current_base_row[308usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[255usize]) * (current_base_row[99usize]))
                        * (current_base_row[99usize])) * (current_base_row[99usize]))),
            (current_base_row[309usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[256usize]) * (current_base_row[100usize]))
                        * (current_base_row[100usize])) * (current_base_row[100usize]))),
            (current_base_row[310usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[259usize]) * (current_base_row[101usize]))
                        * (current_base_row[101usize])) * (current_base_row[101usize]))),
            (current_base_row[311usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[264usize]) * (current_base_row[102usize]))
                        * (current_base_row[102usize])) * (current_base_row[102usize]))),
            (current_base_row[312usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[267usize]) * (current_base_row[103usize]))
                        * (current_base_row[103usize])) * (current_base_row[103usize]))),
            (current_base_row[313usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[272usize]) * (current_base_row[104usize]))
                        * (current_base_row[104usize])) * (current_base_row[104usize]))),
            (current_base_row[314usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[274usize]) * (current_base_row[105usize]))
                        * (current_base_row[105usize])) * (current_base_row[105usize]))),
            (current_base_row[315usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[277usize]) * (current_base_row[106usize]))
                        * (current_base_row[106usize])) * (current_base_row[106usize]))),
            (current_base_row[316usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[278usize]) * (current_base_row[107usize]))
                        * (current_base_row[107usize])) * (current_base_row[107usize]))),
            (current_base_row[317usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[280usize]) * (current_base_row[108usize]))
                        * (current_base_row[108usize])) * (current_base_row[108usize]))),
            (current_base_row[318usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_6058) * ((current_base_row[302usize]) * (node_6089)))),
            (current_base_row[319usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[304usize]) * (node_6079))),
            (current_base_row[320usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[305usize]) * (node_5491))),
            (current_base_row[321usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((node_4039)
                        * ((next_base_row[13usize])
                            + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                        * (next_base_row[14usize]))),
            (current_base_row[322usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[39usize]) * (node_1915))),
            (current_base_row[323usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[39usize])
                        * ((current_base_row[39usize])
                            + (BFieldElement::from_raw_u64(18446744065119617026u64))))),
            (current_base_row[324usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_6097) * (node_6092))),
            (current_base_row[325usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((node_4039) * (next_base_row[13usize]))
                        * ((next_base_row[14usize])
                            + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                        * (node_4043))),
            (current_base_row[326usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((node_5430) * (node_5451)) * (next_base_row[62usize]))),
            (current_base_row[327usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[24usize]) * (current_base_row[27usize]))),
            (current_base_row[328usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[24usize]) * (next_base_row[24usize]))),
            (current_base_row[329usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[319usize]) * (node_6083))),
            (current_base_row[330usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((((current_base_row[10usize])
                        + (BFieldElement::from_raw_u64(18446743897615892521u64)))
                        * ((current_base_row[10usize])
                            + (BFieldElement::from_raw_u64(18446743923385696291u64))))
                        * ((current_base_row[10usize])
                            + (BFieldElement::from_raw_u64(18446743863256154161u64))))
                        * ((current_base_row[10usize])
                            + (BFieldElement::from_raw_u64(18446743828896415801u64))))),
            (current_base_row[331usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_6058)
                        * (((current_base_row[319usize]) * (node_6085)) * (node_6089)))),
            (current_base_row[332usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_4075) * (next_base_row[22usize]))),
            (current_base_row[333usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((next_base_row[44usize]) * (next_base_row[39usize]))),
            (current_base_row[334usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_4075) * (next_base_row[23usize]))),
            (current_base_row[335usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((next_base_row[44usize]) * (next_base_row[40usize]))),
            (current_base_row[336usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_4075) * (next_base_row[24usize]))),
            (current_base_row[337usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((next_base_row[44usize]) * (next_base_row[41usize]))),
            (current_base_row[338usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_4075) * (next_base_row[25usize]))),
            (current_base_row[339usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((next_base_row[44usize]) * (next_base_row[42usize]))),
            (current_base_row[340usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_4075) * (next_base_row[26usize]))),
            (current_base_row[341usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((next_base_row[44usize]) * (next_base_row[43usize]))),
            (current_base_row[342usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_4075) * (next_base_row[39usize]))),
            (current_base_row[343usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((next_base_row[44usize]) * (next_base_row[22usize]))),
            (current_base_row[344usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_4075) * (next_base_row[40usize]))),
            (current_base_row[345usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((next_base_row[44usize]) * (next_base_row[23usize]))),
            (current_base_row[346usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_4075) * (next_base_row[41usize]))),
            (current_base_row[347usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((next_base_row[44usize]) * (next_base_row[24usize]))),
            (current_base_row[348usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_4075) * (next_base_row[42usize]))),
            (current_base_row[349usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((next_base_row[44usize]) * (next_base_row[25usize]))),
            (current_base_row[350usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_4075) * (next_base_row[43usize]))),
            (current_base_row[351usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((next_base_row[44usize]) * (next_base_row[26usize]))),
            (current_base_row[352usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[325usize]) * (next_base_row[16usize]))
                        * ((next_base_row[17usize])
                            + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                        * (node_4048))),
            (current_base_row[353usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[321usize]) * (node_4043)) * (node_4054))
                        * (next_base_row[17usize]))),
            (current_base_row[354usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[39usize]) * (current_base_row[42usize]))),
            (current_base_row[355usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[321usize]) * (next_base_row[15usize]))
                        * (node_4054)) * (next_base_row[17usize]))),
            (current_base_row[356usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[320usize])
                        * (((node_5451) * (node_5435)) * (next_base_row[62usize])))),
            (current_base_row[357usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((node_5426) * (node_5427)) * (current_base_row[62usize]))),
            (current_base_row[358usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[237usize])
                        * ((next_base_row[22usize])
                            * (((current_base_row[39usize])
                                * ((next_base_row[23usize])
                                    + (BFieldElement::from_raw_u64(4294967296u64))))
                                + (BFieldElement::from_raw_u64(
                                    18446744065119617026u64,
                                )))))),
            (current_base_row[359usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[213usize])
                        * ((((node_1182) * (current_base_row[22usize]))
                            + (((node_116) * (node_1184)) * (node_133)))
                            + ((((node_113)
                                + (BFieldElement::from_raw_u64(18446744056529682436u64)))
                                * (node_1184)) * (current_base_row[40usize]))))),
            (current_base_row[360usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[213usize])
                        * (((current_base_row[249usize])
                            * ((current_base_row[41usize])
                                + (BFieldElement::from_raw_u64(18446744060824649731u64))))
                            * ((current_base_row[41usize])
                                + (BFieldElement::from_raw_u64(
                                    18446744056529682436u64,
                                )))))),
            (current_base_row[361usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[213usize])
                        * (((current_base_row[254usize])
                            * ((current_base_row[42usize])
                                + (BFieldElement::from_raw_u64(18446744060824649731u64))))
                            * ((current_base_row[42usize])
                                + (BFieldElement::from_raw_u64(
                                    18446744056529682436u64,
                                )))))),
            (current_base_row[362usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[213usize])
                        * (((current_base_row[295usize])
                            * ((current_base_row[44usize])
                                + (BFieldElement::from_raw_u64(18446744060824649731u64))))
                            * ((current_base_row[44usize])
                                + (BFieldElement::from_raw_u64(
                                    18446744056529682436u64,
                                )))))),
            (current_base_row[363usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[64usize])
                        * ((current_base_row[64usize])
                            + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                        * ((current_base_row[64usize])
                            + (BFieldElement::from_raw_u64(18446744060824649731u64))))
                        * ((current_base_row[64usize])
                            + (BFieldElement::from_raw_u64(18446744056529682436u64))))),
            (current_base_row[364usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((node_5448) * (node_5427)) * (current_base_row[62usize]))
                        * (node_5451))),
            (current_base_row[365usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[304usize]) * (node_6083)) * (node_6085))
                        * (node_6089))),
            (current_base_row[366usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[324usize])
                        * ((((BFieldElement::from_raw_u64(4294967295u64)) + (node_6108))
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (node_6054)))
                            + (((BFieldElement::from_raw_u64(8589934590u64))
                                * (node_6051)) * (node_6054))))),
            (current_base_row[367usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_6058) * ((current_base_row[329usize]) * (node_6089)))),
            (current_base_row[368usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_4524)
                        * ((node_4532)
                            + (BFieldElement::from_raw_u64(18446744065119617026u64))))),
            (current_base_row[369usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[357usize])
                        * (((node_5430) * (node_5435)) * (next_base_row[62usize])))),
            (current_base_row[370usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((node_5455) * (current_base_row[62usize])) * (node_5435))),
            (current_base_row[371usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[320usize]) * (node_5435))
                        * (next_base_row[62usize])) * (node_5439))),
            (current_base_row[372usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[320usize])
                        * (((node_5542) * (node_5439)) * (node_5544)))),
            (current_base_row[373usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[331usize])
                        * ((BFieldElement::from_raw_u64(4294967295u64))
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * ((next_base_row[143usize]) * (next_base_row[144usize])))))
                        * (current_base_row[143usize]))),
            (current_base_row[374usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_6158) * (current_base_row[143usize]))),
        ];
        let ext_constraints = [
            (((BFieldElement::from_raw_u64(4294967295u64))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (current_base_row[5usize])))
                * (((node_51)
                    * ((challenges[3usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * ((((challenges[13usize]) * (current_base_row[0usize]))
                                + ((challenges[14usize]) * (current_base_row[1usize])))
                                + ((challenges[15usize]) * (next_base_row[1usize]))))))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_base_row[2usize]))))
                + ((current_base_row[5usize]) * (node_51)),
            ((node_31)
                * (((next_ext_row[1usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((challenges[29usize]) * (current_ext_row[1usize]))))
                    + (node_74)))
                + ((node_34)
                    * (((next_ext_row[1usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (challenges[29usize]))) + (node_74))),
            ((((((next_ext_row[2usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((challenges[30usize]) * (current_ext_row[2usize]))))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (next_ext_row[1usize]))) * (node_47))
                * ((BFieldElement::from_raw_u64(4294967295u64))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((next_base_row[4usize]) * (node_90)))))
                + ((node_88) * (next_base_row[6usize]))) + ((node_88) * (node_90)),
            ((((((((((((((((((((((((((((((((((((((((((((((current_base_row[216usize])
                * (node_120))
                + ((current_base_row[205usize])
                    * ((next_base_row[22usize]) + (node_525))))
                + ((current_base_row[220usize]) * (node_120)))
                + ((current_base_row[206usize])
                    * (((((((((((((((((current_base_row[283usize]) * (node_810))
                        + ((current_base_row[195usize]) * (node_812)))
                        + ((current_base_row[196usize])
                            * ((next_base_row[22usize]) + (node_532))))
                        + ((current_base_row[197usize])
                            * ((next_base_row[22usize]) + (node_534))))
                        + ((current_base_row[198usize])
                            * ((next_base_row[22usize]) + (node_536))))
                        + ((current_base_row[199usize])
                            * ((next_base_row[22usize]) + (node_538))))
                        + ((current_base_row[284usize])
                            * ((next_base_row[22usize]) + (node_540))))
                        + ((current_base_row[285usize])
                            * ((next_base_row[22usize]) + (node_542))))
                        + ((current_base_row[286usize])
                            * ((next_base_row[22usize]) + (node_544))))
                        + ((current_base_row[287usize])
                            * ((next_base_row[22usize]) + (node_546))))
                        + ((current_base_row[288usize])
                            * ((next_base_row[22usize]) + (node_548))))
                        + ((current_base_row[289usize])
                            * ((next_base_row[22usize]) + (node_550))))
                        + ((current_base_row[290usize])
                            * ((next_base_row[22usize]) + (node_552))))
                        + ((current_base_row[291usize])
                            * ((next_base_row[22usize]) + (node_554))))
                        + ((current_base_row[292usize])
                            * ((next_base_row[22usize]) + (node_556))))
                        + ((current_base_row[293usize])
                            * ((next_base_row[22usize]) + (node_854))))))
                + ((current_base_row[225usize])
                    * (((((((((((((((((current_base_row[283usize]) * (node_864))
                        + ((current_base_row[195usize])
                            * ((node_860)
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * ((((((((((((((((node_229)
                                        + ((challenges[33usize]) * (current_base_row[22usize])))
                                        + (node_600)) + (node_602)) + (node_604)) + (node_606))
                                        + (node_608)) + (node_610)) + (node_612)) + (node_614))
                                        + (node_616)) + (node_618)) + (node_620)) + (node_622))
                                        + (node_624)) + (node_861))))))
                        + ((current_base_row[196usize])
                            * ((node_860)
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * ((((((((((((((((node_299) + (node_598))
                                        + ((challenges[34usize]) * (current_base_row[22usize])))
                                        + (node_602)) + (node_604)) + (node_606)) + (node_608))
                                        + (node_610)) + (node_612)) + (node_614)) + (node_616))
                                        + (node_618)) + (node_620)) + (node_622)) + (node_624))
                                        + (node_861))))))
                        + ((current_base_row[197usize])
                            * ((node_860)
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * ((((((((((((((((node_346) + (node_598)) + (node_600))
                                        + ((challenges[35usize]) * (current_base_row[22usize])))
                                        + (node_604)) + (node_606)) + (node_608)) + (node_610))
                                        + (node_612)) + (node_614)) + (node_616)) + (node_618))
                                        + (node_620)) + (node_622)) + (node_624)) + (node_861))))))
                        + ((current_base_row[198usize])
                            * ((node_860)
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * ((((((((((((((((node_390) + (node_598)) + (node_600))
                                        + (node_602))
                                        + ((challenges[36usize]) * (current_base_row[22usize])))
                                        + (node_606)) + (node_608)) + (node_610)) + (node_612))
                                        + (node_614)) + (node_616)) + (node_618)) + (node_620))
                                        + (node_622)) + (node_624)) + (node_861))))))
                        + ((current_base_row[199usize])
                            * ((node_860)
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * ((((((((((((((((node_433) + (node_598)) + (node_600))
                                        + (node_602)) + (node_604))
                                        + ((challenges[37usize]) * (current_base_row[22usize])))
                                        + (node_608)) + (node_610)) + (node_612)) + (node_614))
                                        + (node_616)) + (node_618)) + (node_620)) + (node_622))
                                        + (node_624)) + (node_861))))))
                        + ((current_base_row[284usize])
                            * ((node_860)
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (((((((((((((((((challenges[32usize])
                                        * (current_base_row[28usize])) + (node_598)) + (node_600))
                                        + (node_602)) + (node_604)) + (node_606))
                                        + ((challenges[38usize]) * (current_base_row[22usize])))
                                        + (node_610)) + (node_612)) + (node_614)) + (node_616))
                                        + (node_618)) + (node_620)) + (node_622)) + (node_624))
                                        + (node_861))))))
                        + ((current_base_row[285usize])
                            * ((node_860)
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (((((((((((((((((challenges[32usize])
                                        * (current_base_row[29usize])) + (node_598)) + (node_600))
                                        + (node_602)) + (node_604)) + (node_606)) + (node_608))
                                        + ((challenges[39usize]) * (current_base_row[22usize])))
                                        + (node_612)) + (node_614)) + (node_616)) + (node_618))
                                        + (node_620)) + (node_622)) + (node_624)) + (node_861))))))
                        + ((current_base_row[286usize])
                            * ((node_860)
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (((((((((((((((((challenges[32usize])
                                        * (current_base_row[30usize])) + (node_598)) + (node_600))
                                        + (node_602)) + (node_604)) + (node_606)) + (node_608))
                                        + (node_610))
                                        + ((challenges[40usize]) * (current_base_row[22usize])))
                                        + (node_614)) + (node_616)) + (node_618)) + (node_620))
                                        + (node_622)) + (node_624)) + (node_861))))))
                        + ((current_base_row[287usize])
                            * ((node_860)
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (((((((((((((((((challenges[32usize])
                                        * (current_base_row[31usize])) + (node_598)) + (node_600))
                                        + (node_602)) + (node_604)) + (node_606)) + (node_608))
                                        + (node_610)) + (node_612))
                                        + ((challenges[41usize]) * (current_base_row[22usize])))
                                        + (node_616)) + (node_618)) + (node_620)) + (node_622))
                                        + (node_624)) + (node_861))))))
                        + ((current_base_row[288usize])
                            * ((node_860)
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * ((((((((((((((((node_1050) + (node_598)) + (node_600))
                                        + (node_602)) + (node_604)) + (node_606)) + (node_608))
                                        + (node_610)) + (node_612)) + (node_614))
                                        + ((challenges[42usize]) * (current_base_row[22usize])))
                                        + (node_618)) + (node_620)) + (node_622)) + (node_624))
                                        + (node_861))))))
                        + ((current_base_row[289usize])
                            * ((node_860)
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (((((((((((((((((challenges[32usize])
                                        * (current_base_row[33usize])) + (node_598)) + (node_600))
                                        + (node_602)) + (node_604)) + (node_606)) + (node_608))
                                        + (node_610)) + (node_612)) + (node_614)) + (node_616))
                                        + ((challenges[43usize]) * (current_base_row[22usize])))
                                        + (node_620)) + (node_622)) + (node_624)) + (node_861))))))
                        + ((current_base_row[290usize])
                            * ((node_860)
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (((((((((((((((((challenges[32usize])
                                        * (current_base_row[34usize])) + (node_598)) + (node_600))
                                        + (node_602)) + (node_604)) + (node_606)) + (node_608))
                                        + (node_610)) + (node_612)) + (node_614)) + (node_616))
                                        + (node_618))
                                        + ((challenges[44usize]) * (current_base_row[22usize])))
                                        + (node_622)) + (node_624)) + (node_861))))))
                        + ((current_base_row[291usize])
                            * ((node_860)
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (((((((((((((((((challenges[32usize])
                                        * (current_base_row[35usize])) + (node_598)) + (node_600))
                                        + (node_602)) + (node_604)) + (node_606)) + (node_608))
                                        + (node_610)) + (node_612)) + (node_614)) + (node_616))
                                        + (node_618)) + (node_620))
                                        + ((challenges[45usize]) * (current_base_row[22usize])))
                                        + (node_624)) + (node_861))))))
                        + ((current_base_row[292usize])
                            * ((node_860)
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (((((((((((((((((challenges[32usize])
                                        * (current_base_row[36usize])) + (node_598)) + (node_600))
                                        + (node_602)) + (node_604)) + (node_606)) + (node_608))
                                        + (node_610)) + (node_612)) + (node_614)) + (node_616))
                                        + (node_618)) + (node_620)) + (node_622))
                                        + ((challenges[46usize]) * (current_base_row[22usize])))
                                        + (node_861))))))
                        + ((current_base_row[293usize])
                            * ((node_860)
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (((((((((((((((((challenges[32usize])
                                        * (current_base_row[37usize])) + (node_598)) + (node_600))
                                        + (node_602)) + (node_604)) + (node_606)) + (node_608))
                                        + (node_610)) + (node_612)) + (node_614)) + (node_616))
                                        + (node_618)) + (node_620)) + (node_622)) + (node_624))
                                        + ((challenges[47usize])
                                            * (current_base_row[22usize])))))))))
                + ((current_base_row[233usize]) * (node_1181)))
                + ((current_base_row[236usize]) * (node_120)))
                + ((current_base_row[213usize])
                    * ((node_1184) * (current_base_row[39usize]))))
                + ((current_base_row[240usize])
                    * ((node_120)
                        + (BFieldElement::from_raw_u64(18446744065119617026u64)))))
                + ((current_base_row[265usize]) * (node_1249)))
                + ((current_base_row[241usize]) * (node_1251)))
                + ((current_base_row[242usize])
                    * (((node_1255) * (current_base_row[39usize]))
                        + ((current_base_row[271usize]) * (node_124)))))
                + ((current_base_row[223usize])
                    * ((current_base_row[22usize])
                        + (BFieldElement::from_raw_u64(18446744065119617026u64)))))
                + ((current_base_row[218usize]) * (node_120)))
                + ((current_base_row[224usize]) * (node_120)))
                + ((current_base_row[230usize]) * (node_120)))
                + ((current_base_row[232usize])
                    * ((current_base_row[27usize]) + (node_528))))
                + ((current_base_row[257usize]) * (node_120)))
                + ((current_base_row[258usize]) * (node_120)))
                + ((current_base_row[260usize])
                    * ((node_810)
                        + (BFieldElement::from_raw_u64(18446744026464911371u64)))))
                + ((current_base_row[262usize]) * (node_120)))
                + ((current_base_row[228usize]) * ((node_810) + (node_530))))
                + ((current_base_row[261usize]) * ((node_810) + (node_525))))
                + ((current_base_row[229usize]) * (node_1912)))
                + ((current_base_row[263usize])
                    * ((node_1913)
                        + (BFieldElement::from_raw_u64(18446744065119617026u64)))))
                + ((current_base_row[235usize])
                    * ((current_base_row[39usize]) * (node_1918))))
                + ((current_base_row[237usize])
                    * ((current_base_row[22usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((BFieldElement::from_raw_u64(18446744069414584320u64))
                                * (next_base_row[23usize])) + (next_base_row[22usize]))))))
                + ((current_base_row[234usize]) * (node_120)))
                + ((current_base_row[238usize]) * (node_120)))
                + ((current_base_row[243usize]) * (node_120)))
                + ((current_base_row[270usize]) * (node_120)))
                + ((current_base_row[250usize]) * (node_120)))
                + ((current_base_row[266usize])
                    * (((current_base_row[22usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (node_1934))) + (node_1937))))
                + ((current_base_row[273usize]) * (node_120)))
                + ((current_base_row[268usize]) * ((node_810) + (node_534))))
                + ((current_base_row[269usize])
                    * ((next_base_row[22usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * ((node_1972)
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (node_1983)))))))
                + ((current_base_row[281usize])
                    * ((((node_1913)
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (node_1997)))
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (node_2000)))
                        + (BFieldElement::from_raw_u64(18446744065119617026u64)))))
                + ((current_base_row[282usize]) * (node_1912)))
                + ((current_base_row[275usize]) * (node_120)))
                + ((current_base_row[276usize]) * (node_120)))
                + ((current_base_row[298usize]) * (current_base_row[295usize])))
                + ((current_base_row[297usize])
                    * (((challenges[38usize]) * ((next_base_row[28usize]) + (node_540)))
                        + ((challenges[39usize])
                            * (((next_base_row[29usize]) + (node_542))
                                + (BFieldElement::from_raw_u64(
                                    18446744047939747846u64,
                                ))))))) + ((current_base_row[300usize]) * (node_1571)))
                + ((current_base_row[301usize]) * (node_1505))) * (node_3926))
                + ((node_113) * (next_base_row[8usize])),
            ((((((((((((((((((((((((((((((((((((((((((((((current_base_row[216usize])
                * (node_124)) + ((current_base_row[205usize]) * (node_529)))
                + ((current_base_row[220usize]) * (node_124)))
                + ((current_base_row[206usize]) * (current_base_row[323usize])))
                + ((current_base_row[225usize]) * (current_base_row[323usize])))
                + ((current_base_row[233usize]) * (node_120)))
                + ((current_base_row[236usize]) * (node_124)))
                + ((current_base_row[213usize])
                    * ((node_1184) * (current_base_row[22usize]))))
                + ((current_base_row[240usize])
                    * (((next_base_row[20usize]) + (node_112))
                        + (BFieldElement::from_raw_u64(18446744060824649731u64)))))
                + ((current_base_row[265usize]) * (node_1250)))
                + ((current_base_row[241usize]) * (node_120)))
                + ((current_base_row[242usize])
                    * (((node_1255) * (node_1252))
                        + ((current_base_row[271usize]) * (node_128)))))
                + ((current_base_row[223usize]) * (node_120)))
                + ((current_base_row[218usize]) * (node_124)))
                + ((current_base_row[224usize]) * (node_124)))
                + ((current_base_row[230usize]) * (node_124)))
                + ((current_base_row[232usize])
                    * ((current_base_row[28usize]) + (node_530))))
                + ((current_base_row[257usize]) * (node_124)))
                + ((current_base_row[258usize]) * (node_124)))
                + ((current_base_row[260usize]) * (node_120)))
                + ((current_base_row[262usize]) * (node_124)))
                + ((current_base_row[228usize]) * (node_120)))
                + ((current_base_row[261usize]) * (node_120)))
                + ((current_base_row[229usize]) * (node_120)))
                + ((current_base_row[263usize]) * (node_120)))
                + ((current_base_row[235usize]) * ((node_1915) * (node_1918))))
                + (current_base_row[358usize]))
                + ((current_base_row[234usize]) * (node_124)))
                + ((current_base_row[238usize]) * (node_124)))
                + ((current_base_row[243usize]) * (node_124)))
                + ((current_base_row[270usize]) * (node_124)))
                + ((current_base_row[250usize]) * (node_124)))
                + ((current_base_row[266usize]) * (node_120)))
                + ((current_base_row[273usize]) * (node_124)))
                + ((current_base_row[268usize]) * ((node_1968) + (node_536))))
                + ((current_base_row[269usize])
                    * ((next_base_row[23usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((((current_base_row[23usize])
                                * (current_base_row[25usize]))
                                + ((current_base_row[22usize])
                                    * (current_base_row[26usize])))
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (current_base_row[327usize]))) + (node_1983))))))
                + ((current_base_row[281usize])
                    * ((((((current_base_row[23usize]) * (next_base_row[22usize]))
                        + ((current_base_row[22usize]) * (next_base_row[23usize])))
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (current_base_row[328usize]))) + (node_1997))
                        + (node_2000))))
                + ((current_base_row[282usize])
                    * ((next_base_row[23usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * ((current_base_row[24usize])
                                * (current_base_row[22usize]))))))
                + ((current_base_row[275usize]) * (node_124)))
                + ((current_base_row[276usize]) * (node_124)))
                + ((current_base_row[298usize]) * (node_2126)))
                + (current_ext_row[85usize]))
                + ((current_base_row[300usize]) * (node_2210)))
                + ((current_base_row[301usize]) * (node_2210))) * (node_3926))
                + ((node_1181) * (next_base_row[8usize])),
            ((((((((((((((((((((((((((((((((((((((((((((((current_base_row[216usize])
                * (node_128)) + ((current_base_row[205usize]) * (node_531)))
                + ((current_base_row[220usize]) * (node_128)))
                + ((current_base_row[206usize]) * (current_base_row[303usize])))
                + ((current_base_row[225usize]) * (current_base_row[303usize])))
                + ((current_base_row[233usize]) * (node_124)))
                + ((current_base_row[236usize]) * (node_128)))
                + ((current_base_row[213usize])
                    * ((((((current_base_row[11usize]) + (node_292))
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * ((BFieldElement::from_raw_u64(8589934590u64))
                                * (current_base_row[41usize])))) + (node_144))
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * ((BFieldElement::from_raw_u64(137438953440u64))
                                * (current_base_row[43usize]))))
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * ((BFieldElement::from_raw_u64(549755813760u64))
                                * (current_base_row[44usize]))))))
                + ((current_base_row[240usize])
                    * ((next_base_row[21usize]) + (node_525))))
                + ((current_base_row[265usize]) * (node_261)))
                + ((current_base_row[241usize]) * (node_124)))
                + ((current_base_row[242usize])
                    * (((node_1255) * (node_1250))
                        + ((current_base_row[271usize]) * (node_1251)))))
                + ((current_base_row[223usize]) * (node_124)))
                + ((current_base_row[218usize]) * (node_128)))
                + ((current_base_row[224usize]) * (node_128)))
                + ((current_base_row[230usize]) * (node_128)))
                + ((current_base_row[232usize])
                    * ((current_base_row[29usize]) + (node_532))))
                + ((current_base_row[257usize]) * (node_128)))
                + ((current_base_row[258usize]) * (node_128)))
                + ((current_base_row[260usize]) * (node_124)))
                + ((current_base_row[262usize]) * (node_128)))
                + ((current_base_row[228usize]) * (node_124)))
                + ((current_base_row[261usize]) * (node_124)))
                + ((current_base_row[229usize]) * (node_124)))
                + ((current_base_row[263usize]) * (node_124)))
                + ((current_base_row[235usize])
                    * ((next_base_row[22usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (node_1918)))))
                + ((current_base_row[237usize]) * (node_531)))
                + ((current_base_row[234usize]) * (node_128)))
                + ((current_base_row[238usize]) * (node_128)))
                + ((current_base_row[243usize]) * (node_128)))
                + ((current_base_row[270usize]) * (node_128)))
                + ((current_base_row[250usize]) * (node_128)))
                + ((current_base_row[266usize]) * (node_124)))
                + ((current_base_row[273usize]) * (node_128)))
                + ((current_base_row[268usize]) * ((node_1970) + (node_538))))
                + ((current_base_row[269usize])
                    * ((next_base_row[24usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((((current_base_row[24usize])
                                * (current_base_row[25usize]))
                                + ((current_base_row[23usize])
                                    * (current_base_row[26usize])))
                                + ((current_base_row[22usize])
                                    * (current_base_row[27usize])))
                                + (current_base_row[327usize]))))))
                + ((current_base_row[281usize])
                    * (((((current_base_row[24usize]) * (next_base_row[22usize]))
                        + (node_1934))
                        + ((current_base_row[22usize]) * (next_base_row[24usize])))
                        + (current_base_row[328usize]))))
                + ((current_base_row[282usize])
                    * ((next_base_row[24usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (node_1972)))))
                + ((current_base_row[275usize]) * (node_128)))
                + ((current_base_row[276usize]) * (node_128)))
                + ((current_base_row[298usize]) * (node_120)))
                + ((current_base_row[297usize]) * (current_base_row[295usize])))
                + ((current_base_row[300usize])
                    * ((current_ext_row[83usize]) + (node_2186))))
                + ((current_base_row[301usize])
                    * (((current_ext_row[7usize]) * (current_ext_row[73usize]))
                        + (node_2186)))) * (node_3926))
                + (((next_base_row[11usize]) + (node_525)) * (next_base_row[8usize])),
            ((((((((((((((((((((((((((((((((((((((((((((((current_base_row[216usize])
                * (node_116)) + ((current_base_row[205usize]) * (node_533)))
                + ((current_base_row[220usize]) * (node_116)))
                + ((current_base_row[206usize]) * (current_base_row[249usize])))
                + ((current_base_row[225usize]) * (current_base_row[249usize])))
                + ((current_base_row[233usize]) * (node_128)))
                + ((current_base_row[236usize]) * (node_1182)))
                + (current_base_row[359usize]))
                + ((current_base_row[240usize])
                    * ((next_base_row[9usize]) + (node_525))))
                + ((current_base_row[265usize]) * (node_1177)))
                + ((current_base_row[241usize]) * (node_128)))
                + ((current_base_row[242usize])
                    * (((node_1255) * (node_1249))
                        + ((current_base_row[271usize]) * (node_120)))))
                + ((current_base_row[223usize]) * (node_128)))
                + ((current_base_row[218usize]) * (node_116)))
                + ((current_base_row[224usize]) * (node_116)))
                + ((current_base_row[230usize]) * (node_1182)))
                + ((current_base_row[232usize])
                    * ((current_base_row[30usize]) + (node_534))))
                + ((current_base_row[257usize]) * (node_1182)))
                + ((current_base_row[258usize]) * (node_1182)))
                + ((current_base_row[260usize]) * (node_128)))
                + ((current_base_row[262usize]) * (node_1182)))
                + ((current_base_row[228usize]) * (node_128)))
                + ((current_base_row[261usize]) * (node_128)))
                + ((current_base_row[229usize]) * (node_128)))
                + ((current_base_row[263usize]) * (node_128)))
                + ((current_base_row[235usize]) * (node_120)))
                + ((current_base_row[237usize]) * (node_533)))
                + ((current_base_row[234usize]) * (node_1182)))
                + ((current_base_row[238usize]) * (node_1182)))
                + ((current_base_row[243usize]) * (node_1182)))
                + ((current_base_row[270usize]) * (node_1182)))
                + ((current_base_row[250usize]) * (node_1182)))
                + ((current_base_row[266usize]) * (node_128)))
                + ((current_base_row[273usize]) * (node_1182)))
                + ((current_base_row[268usize]) * (node_1585)))
                + ((current_base_row[269usize]) * (node_1585)))
                + ((current_base_row[281usize]) * (node_261)))
                + ((current_base_row[282usize]) * (node_1232)))
                + ((current_base_row[275usize]) * (node_116)))
                + ((current_base_row[276usize]) * (node_116)))
                + ((current_base_row[298usize]) * (node_124)))
                + ((current_base_row[297usize]) * (node_2126)))
                + ((current_base_row[300usize])
                    * ((node_1970)
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * ((current_base_row[354usize])
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (node_2258)))))))
                + ((current_base_row[301usize])
                    * ((node_1970)
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * ((current_base_row[40usize])
                                * (current_base_row[39usize])))))) * (node_3926))
                + ((node_120) * (next_base_row[8usize])),
            ((((((((((((((((((((((((((((((((((((((((((((((current_base_row[216usize])
                * (current_base_row[323usize]))
                + ((current_base_row[205usize]) * (node_535)))
                + ((current_base_row[220usize]) * (current_base_row[323usize])))
                + ((current_base_row[206usize]) * (current_base_row[254usize])))
                + ((current_base_row[225usize]) * (current_base_row[254usize])))
                + ((current_base_row[233usize]) * (node_1182)))
                + ((current_base_row[236usize]) * (node_261)))
                + ((current_base_row[213usize]) * (current_base_row[303usize])))
                + ((current_base_row[240usize]) * (node_261)))
                + ((current_base_row[265usize]) * (node_864)))
                + ((current_base_row[241usize]) * (node_261)))
                + ((current_base_row[242usize]) * (node_261)))
                + ((current_base_row[223usize]) * (node_1182)))
                + ((current_base_row[218usize]) * (current_base_row[323usize])))
                + ((current_base_row[224usize]) * (current_base_row[323usize])))
                + ((current_base_row[230usize]) * (node_1661)))
                + ((current_base_row[232usize])
                    * ((current_base_row[31usize]) + (node_536))))
                + ((current_base_row[257usize]) * (node_261)))
                + ((current_base_row[258usize])
                    * ((node_261) + (BFieldElement::from_raw_u64(42949672950u64)))))
                + ((current_base_row[260usize]) * (node_1182)))
                + ((current_base_row[262usize])
                    * ((node_261)
                        + (BFieldElement::from_raw_u64(18446744026464911371u64)))))
                + ((current_base_row[228usize]) * (node_1182)))
                + ((current_base_row[261usize]) * (node_116)))
                + ((current_base_row[229usize]) * (node_1182)))
                + ((current_base_row[263usize]) * (node_1182)))
                + ((current_base_row[235usize]) * (node_124)))
                + ((current_base_row[237usize]) * (node_535)))
                + ((current_base_row[234usize]) * (node_1230)))
                + ((current_base_row[238usize]) * (node_1230)))
                + ((current_base_row[243usize]) * (node_1230)))
                + ((current_base_row[270usize]) * (node_261)))
                + ((current_base_row[250usize]) * (node_1230)))
                + ((current_base_row[266usize]) * (node_1182)))
                + ((current_base_row[273usize]) * (node_261)))
                + ((current_base_row[268usize]) * (node_1586)))
                + ((current_base_row[269usize]) * (node_1586)))
                + ((current_base_row[281usize]) * (node_1177)))
                + ((current_base_row[282usize]) * (node_1233)))
                + ((current_base_row[275usize]) * (current_base_row[323usize])))
                + ((current_base_row[276usize]) * (current_base_row[323usize])))
                + ((current_base_row[298usize]) * (node_128)))
                + ((current_base_row[297usize]) * (node_120)))
                + ((current_base_row[300usize])
                    * ((node_2268)
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((((current_base_row[40usize])
                                * (current_base_row[42usize]))
                                + ((current_base_row[39usize])
                                    * (current_base_row[43usize])))
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (node_2259))) + (node_2258))))))
                + ((current_base_row[301usize])
                    * ((node_2268)
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * ((current_base_row[41usize])
                                * (current_base_row[39usize])))))) * (node_3926))
                + ((node_124) * (next_base_row[8usize])),
            ((((((((((((((((((((((((((((((((((((((((((((((current_base_row[216usize])
                * (current_base_row[303usize]))
                + ((current_base_row[205usize]) * (node_537)))
                + ((current_base_row[220usize]) * (current_base_row[303usize])))
                + ((current_base_row[206usize]) * (node_154)))
                + ((current_base_row[225usize]) * (node_154)))
                + ((current_base_row[233usize]) * (node_261)))
                + ((current_base_row[236usize]) * (node_1177)))
                + (current_base_row[360usize]))
                + ((current_base_row[240usize]) * (node_1177)))
                + ((current_base_row[265usize]) * (node_516)))
                + ((current_base_row[241usize]) * (node_1177)))
                + ((current_base_row[242usize]) * (node_1177)))
                + ((current_base_row[223usize]) * (node_812)))
                + ((current_base_row[218usize]) * (current_base_row[303usize])))
                + ((current_base_row[224usize]) * (current_base_row[303usize])))
                + ((current_base_row[230usize]) * (node_1662)))
                + ((current_base_row[232usize]) * (node_120)))
                + ((current_base_row[257usize]) * (node_1177)))
                + ((current_base_row[258usize])
                    * ((node_201)
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * ((((((node_1050)
                                + ((challenges[33usize]) * (current_base_row[33usize])))
                                + ((challenges[34usize]) * (current_base_row[34usize])))
                                + ((challenges[35usize]) * (current_base_row[35usize])))
                                + ((challenges[36usize]) * (current_base_row[36usize])))
                                + ((challenges[37usize]) * (current_base_row[37usize])))))))
                + ((current_base_row[260usize]) * (node_261)))
                + ((current_base_row[262usize])
                    * ((((((((challenges[32usize]) * (next_base_row[32usize]))
                        + ((challenges[33usize]) * (next_base_row[33usize])))
                        + ((challenges[34usize]) * (next_base_row[34usize])))
                        + ((challenges[35usize]) * (next_base_row[35usize])))
                        + ((challenges[36usize]) * (next_base_row[36usize])))
                        + ((challenges[37usize]) * (next_base_row[37usize])))
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (node_607)))))
                + ((current_base_row[228usize]) * (node_1230)))
                + ((current_base_row[261usize]) * (node_261)))
                + ((current_base_row[229usize]) * (node_1230)))
                + ((current_base_row[263usize]) * (node_261)))
                + ((current_base_row[235usize]) * (node_128)))
                + ((current_base_row[237usize]) * (node_537)))
                + ((current_base_row[234usize]) * (node_1231)))
                + ((current_base_row[238usize]) * (node_1231)))
                + ((current_base_row[243usize]) * (node_1231)))
                + ((current_base_row[270usize]) * (node_1177)))
                + ((current_base_row[250usize]) * (node_1231)))
                + ((current_base_row[266usize]) * (node_261)))
                + ((current_base_row[273usize]) * (node_1177)))
                + ((current_base_row[268usize]) * (node_1587)))
                + ((current_base_row[269usize]) * (node_1587)))
                + ((current_base_row[281usize])
                    * ((((((((((((((node_194) + (node_197)) + (node_200)) + (node_203))
                        + (node_206)) + (node_209)) + (node_212)) + (node_215))
                        + (node_218)) + (node_221)) + (node_224)) + (node_227))
                        + (node_859))
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((((((((((((node_602) + (node_604)) + (node_606))
                                + (node_608)) + (node_610)) + (node_612)) + (node_614))
                                + (node_616)) + (node_618)) + (node_620)) + (node_622))
                                + (node_624)) + (node_861))))))
                + ((current_base_row[282usize]) * (node_1234)))
                + ((current_base_row[275usize]) * (current_base_row[303usize])))
                + ((current_base_row[276usize]) * (current_base_row[303usize])))
                + ((current_base_row[298usize]) * (node_1182)))
                + ((current_base_row[297usize]) * (node_124)))
                + ((current_base_row[300usize])
                    * ((node_2271)
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * ((((current_base_row[210usize])
                                + ((current_base_row[40usize])
                                    * (current_base_row[43usize])))
                                + ((current_base_row[39usize])
                                    * (current_base_row[44usize]))) + (node_2259))))))
                + ((current_base_row[301usize])
                    * ((node_2271)
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (current_base_row[354usize]))))) * (node_3926))
                + ((node_128) * (next_base_row[8usize])),
            ((((((((((((((((((((((((((((((((((((((((((((((current_base_row[216usize])
                * (current_base_row[249usize]))
                + ((current_base_row[205usize]) * (node_539)))
                + ((current_base_row[220usize]) * (current_base_row[249usize])))
                + ((current_base_row[206usize]) * (node_120)))
                + ((current_base_row[225usize]) * (node_120)))
                + ((current_base_row[233usize]) * (node_1177)))
                + ((current_base_row[236usize]) * (node_864)))
                + (current_base_row[361usize]))
                + ((current_base_row[240usize]) * (node_864)))
                + ((current_base_row[265usize]) * (node_520)))
                + ((current_base_row[241usize]) * (node_864)))
                + ((current_base_row[242usize]) * (node_864)))
                + ((current_base_row[223usize]) * (node_1230)))
                + ((current_base_row[218usize]) * (current_base_row[249usize])))
                + ((current_base_row[224usize]) * (current_base_row[249usize])))
                + ((current_base_row[230usize]) * (node_1663)))
                + ((current_base_row[232usize]) * (node_124)))
                + ((current_base_row[257usize]) * (node_864)))
                + ((current_base_row[258usize])
                    * ((next_ext_row[6usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (current_ext_row[67usize])))))
                + ((current_base_row[260usize]) * (node_1177)))
                + ((current_base_row[262usize])
                    * ((next_ext_row[6usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (current_ext_row[68usize])))))
                + ((current_base_row[228usize]) * (node_1231)))
                + ((current_base_row[261usize]) * (node_1177)))
                + ((current_base_row[229usize]) * (node_1231)))
                + ((current_base_row[263usize]) * (node_1177)))
                + ((current_base_row[235usize]) * (node_1182)))
                + ((current_base_row[237usize]) * (node_539)))
                + ((current_base_row[234usize]) * (node_1232)))
                + ((current_base_row[238usize]) * (node_1232)))
                + ((current_base_row[243usize]) * (node_1232)))
                + ((current_base_row[270usize]) * (node_1909)))
                + ((current_base_row[250usize]) * (node_1232)))
                + ((current_base_row[266usize]) * (node_1177)))
                + ((current_base_row[273usize]) * (node_1909)))
                + ((current_base_row[268usize]) * (node_1588)))
                + ((current_base_row[269usize]) * (node_1588)))
                + ((current_base_row[281usize]) * (node_120)))
                + ((current_base_row[282usize]) * (node_1235)))
                + ((current_base_row[275usize]) * (current_base_row[249usize])))
                + ((current_base_row[276usize]) * (current_base_row[249usize])))
                + ((current_base_row[298usize]) * (node_520)))
                + ((current_base_row[297usize]) * (node_128)))
                + ((current_base_row[300usize]) * (node_120)))
                + ((current_base_row[301usize]) * (node_120))) * (node_3926))
                + ((node_261) * (next_base_row[8usize])),
            ((((((((((((((((((((((((((((((((((((((((((((((current_base_row[216usize])
                * (current_base_row[254usize]))
                + ((current_base_row[205usize]) * (node_541)))
                + ((current_base_row[220usize]) * (current_base_row[254usize])))
                + ((current_base_row[206usize]) * (node_124)))
                + ((current_base_row[225usize]) * (node_124)))
                + ((current_base_row[233usize]) * (node_864)))
                + ((current_base_row[236usize]) * (node_516)))
                + ((current_base_row[213usize]) * (current_base_row[299usize])))
                + ((current_base_row[240usize]) * (node_516)))
                + ((current_base_row[265usize]) * (node_524)))
                + ((current_base_row[241usize]) * (node_516)))
                + ((current_base_row[242usize]) * (node_516)))
                + ((current_base_row[223usize]) * (node_1231)))
                + ((current_base_row[218usize]) * (current_base_row[254usize])))
                + ((current_base_row[224usize]) * (current_base_row[254usize])))
                + ((current_base_row[230usize]) * (node_1664)))
                + ((current_base_row[232usize]) * (node_128)))
                + ((current_base_row[257usize]) * (node_516)))
                + ((current_base_row[258usize]) * (node_516)))
                + ((current_base_row[260usize]) * (node_1820)))
                + ((current_base_row[262usize]) * (node_516)))
                + ((current_base_row[228usize]) * (node_1232)))
                + ((current_base_row[261usize]) * (node_1909)))
                + ((current_base_row[229usize]) * (node_1232)))
                + ((current_base_row[263usize]) * (node_1909)))
                + ((current_base_row[235usize]) * (node_1230)))
                + ((current_base_row[237usize]) * (node_541)))
                + ((current_base_row[234usize]) * (node_1233)))
                + ((current_base_row[238usize]) * (node_1233)))
                + ((current_base_row[243usize]) * (node_1233)))
                + ((current_base_row[270usize]) * (node_516)))
                + ((current_base_row[250usize]) * (node_1233)))
                + ((current_base_row[266usize])
                    * (((((((((((((((node_191) + (node_194)) + (node_197)) + (node_200))
                        + (node_203)) + (node_206)) + (node_209)) + (node_212))
                        + (node_215)) + (node_218)) + (node_221)) + (node_224))
                        + (node_227)) + (node_859))
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * ((((((((((((((node_600) + (node_602)) + (node_604))
                                + (node_606)) + (node_608)) + (node_610)) + (node_612))
                                + (node_614)) + (node_616)) + (node_618)) + (node_620))
                                + (node_622)) + (node_624)) + (node_861))))))
                + ((current_base_row[273usize]) * (node_516)))
                + ((current_base_row[268usize]) * (node_1589)))
                + ((current_base_row[269usize]) * (node_1589)))
                + ((current_base_row[281usize]) * (node_124)))
                + ((current_base_row[282usize]) * (node_1236)))
                + ((current_base_row[275usize]) * (current_base_row[254usize])))
                + ((current_base_row[276usize]) * (current_base_row[254usize])))
                + ((current_base_row[298usize]) * (node_524)))
                + ((current_base_row[297usize]) * (node_1182)))
                + ((current_base_row[300usize]) * (node_124)))
                + ((current_base_row[301usize]) * (node_124))) * (node_3926))
                + ((node_1177) * (next_base_row[8usize])),
            (((((((((((((((((((((((((((((((((((((((((((((current_base_row[216usize])
                * (node_154)) + ((current_base_row[205usize]) * (node_543)))
                + ((current_base_row[220usize]) * (node_154)))
                + ((current_base_row[206usize]) * (node_128)))
                + ((current_base_row[225usize]) * (node_128)))
                + ((current_base_row[233usize]) * (node_516)))
                + ((current_base_row[236usize]) * (node_520)))
                + (current_base_row[362usize]))
                + ((current_base_row[240usize]) * (node_520)))
                + ((current_base_row[241usize]) * (node_520)))
                + ((current_base_row[242usize]) * (node_520)))
                + ((current_base_row[223usize]) * (node_1232)))
                + ((current_base_row[218usize]) * (node_154)))
                + ((current_base_row[224usize]) * (node_154)))
                + ((current_base_row[230usize]) * (node_1665)))
                + ((current_base_row[232usize]) * (node_1182)))
                + ((current_base_row[257usize]) * (node_520)))
                + ((current_base_row[258usize]) * (node_520)))
                + ((current_base_row[260usize]) * (node_520)))
                + ((current_base_row[262usize]) * (node_520)))
                + ((current_base_row[228usize]) * (node_1233)))
                + ((current_base_row[261usize]) * (node_516)))
                + ((current_base_row[229usize]) * (node_1233)))
                + ((current_base_row[263usize]) * (node_516)))
                + ((current_base_row[235usize]) * (node_1231)))
                + ((current_base_row[237usize]) * (node_543)))
                + ((current_base_row[234usize]) * (node_1234)))
                + ((current_base_row[238usize]) * (node_1234)))
                + ((current_base_row[243usize]) * (node_1234)))
                + ((current_base_row[270usize]) * (node_520)))
                + ((current_base_row[250usize]) * (node_1234)))
                + ((current_base_row[266usize]) * (node_516)))
                + ((current_base_row[273usize]) * (node_520)))
                + ((current_base_row[268usize]) * (node_1590)))
                + ((current_base_row[269usize]) * (node_1590)))
                + ((current_base_row[281usize]) * (node_128)))
                + ((current_base_row[282usize]) * (node_1237)))
                + ((current_base_row[275usize]) * (node_154)))
                + ((current_base_row[276usize]) * (node_154)))
                + ((current_base_row[298usize]) * (node_261)))
                + ((current_base_row[297usize]) * (node_520)))
                + ((current_base_row[300usize]) * (node_128)))
                + ((current_base_row[301usize]) * (node_128))) * (node_3926))
                + ((node_864) * (next_base_row[8usize])),
            (((((((((((((((((((((((((((((((((((((((((((((current_base_row[216usize])
                * (node_476)) + ((current_base_row[205usize]) * (node_545)))
                + ((current_base_row[220usize]) * (node_801)))
                + ((current_base_row[206usize]) * (node_116)))
                + ((current_base_row[225usize]) * (node_116)))
                + ((current_base_row[233usize]) * (node_520)))
                + ((current_base_row[236usize]) * (node_524)))
                + ((current_base_row[213usize]) * (node_120)))
                + ((current_base_row[240usize]) * (node_524)))
                + ((current_base_row[241usize]) * (node_524)))
                + ((current_base_row[242usize]) * (node_524)))
                + ((current_base_row[223usize]) * (node_1233)))
                + ((current_base_row[218usize]) * (node_801)))
                + ((current_base_row[224usize]) * (node_476)))
                + ((current_base_row[230usize]) * (node_1666)))
                + ((current_base_row[232usize]) * (node_455)))
                + ((current_base_row[257usize]) * (node_524)))
                + ((current_base_row[258usize]) * (node_524)))
                + ((current_base_row[260usize]) * (node_524)))
                + ((current_base_row[262usize]) * (node_524)))
                + ((current_base_row[228usize]) * (node_1234)))
                + ((current_base_row[261usize]) * (node_520)))
                + ((current_base_row[229usize]) * (node_1234)))
                + ((current_base_row[263usize]) * (node_520)))
                + ((current_base_row[235usize]) * (node_1232)))
                + ((current_base_row[237usize]) * (node_545)))
                + ((current_base_row[234usize]) * (node_1235)))
                + ((current_base_row[238usize]) * (node_1235)))
                + ((current_base_row[243usize]) * (node_1235)))
                + ((current_base_row[270usize]) * (node_524)))
                + ((current_base_row[250usize]) * (node_1235)))
                + ((current_base_row[266usize]) * (node_520)))
                + ((current_base_row[273usize]) * (node_524)))
                + ((current_base_row[268usize]) * (node_1591)))
                + ((current_base_row[269usize]) * (node_1591)))
                + ((current_base_row[281usize]) * (node_1182)))
                + ((current_base_row[282usize]) * (node_1238)))
                + ((current_base_row[275usize]) * (node_801)))
                + ((current_base_row[276usize]) * (node_476)))
                + ((current_base_row[298usize]) * (node_1177)))
                + ((current_base_row[297usize]) * (node_524)))
                + ((current_base_row[300usize]) * (node_1182)))
                + ((current_base_row[301usize]) * (node_1182))) * (node_3926))
                + ((node_516) * (next_base_row[8usize])),
            (((((((((((((((((((((((((((((((((((current_base_row[216usize]) * (node_480))
                + ((current_base_row[205usize]) * (node_547)))
                + ((current_base_row[220usize]) * (node_805)))
                + ((current_base_row[206usize]) * (node_529)))
                + ((current_base_row[225usize]) * (node_516)))
                + ((current_base_row[233usize]) * (node_524)))
                + ((current_base_row[213usize]) * (node_124)))
                + ((current_base_row[223usize]) * (node_1234)))
                + ((current_base_row[218usize])
                    * ((((((current_base_row[195usize])
                        * ((node_810) + (BFieldElement::from_raw_u64(4294967295u64))))
                        + ((current_base_row[196usize])
                            * ((node_810)
                                + (BFieldElement::from_raw_u64(8589934590u64)))))
                        + ((current_base_row[197usize])
                            * ((node_810)
                                + (BFieldElement::from_raw_u64(12884901885u64)))))
                        + ((current_base_row[198usize])
                            * ((node_810)
                                + (BFieldElement::from_raw_u64(17179869180u64)))))
                        + ((current_base_row[199usize])
                            * ((node_810)
                                + (BFieldElement::from_raw_u64(21474836475u64)))))))
                + ((current_base_row[224usize])
                    * ((((((current_base_row[195usize]) * (node_1505))
                        + ((current_base_row[196usize])
                            * ((node_810)
                                + (BFieldElement::from_raw_u64(18446744060824649731u64)))))
                        + ((current_base_row[197usize]) * (node_1571)))
                        + ((current_base_row[198usize])
                            * ((node_810)
                                + (BFieldElement::from_raw_u64(18446744052234715141u64)))))
                        + ((current_base_row[199usize])
                            * ((node_810)
                                + (BFieldElement::from_raw_u64(
                                    18446744047939747846u64,
                                ))))))) + ((current_base_row[230usize]) * (node_455)))
                + ((current_base_row[232usize]) * (node_457)))
                + ((current_base_row[228usize]) * (node_1235)))
                + ((current_base_row[261usize]) * (node_524)))
                + ((current_base_row[229usize]) * (node_1235)))
                + ((current_base_row[263usize]) * (node_524)))
                + ((current_base_row[235usize]) * (node_1233)))
                + ((current_base_row[237usize]) * (node_547)))
                + ((current_base_row[234usize]) * (node_1236)))
                + ((current_base_row[238usize]) * (node_1236)))
                + ((current_base_row[243usize]) * (node_1236)))
                + ((current_base_row[250usize]) * (node_1236)))
                + ((current_base_row[266usize]) * (node_524)))
                + ((current_base_row[268usize]) * (node_1592)))
                + ((current_base_row[269usize]) * (node_1592)))
                + ((current_base_row[281usize]) * (node_516)))
                + ((current_base_row[282usize]) * (node_1239)))
                + ((current_base_row[275usize]) * (node_805)))
                + ((current_base_row[276usize]) * (node_480)))
                + ((current_base_row[298usize])
                    * (((((((((((node_203) + (node_206)) + (node_209)) + (node_212))
                        + (node_215)) + (node_218)) + (node_221)) + (node_224))
                        + (node_227)) + (node_859))
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * ((((((((((node_608) + (node_610)) + (node_612))
                                + (node_614)) + (node_616)) + (node_618)) + (node_620))
                                + (node_622)) + (node_624)) + (node_861))))))
                + ((current_base_row[297usize]) * (node_261)))
                + ((current_base_row[300usize]) * (node_520)))
                + ((current_base_row[301usize]) * (node_520))) * (node_3926))
                + ((node_520) * (next_base_row[8usize])),
            (((((((((((((((((((((((((((((((current_base_row[216usize]) * (node_484))
                + ((current_base_row[205usize]) * (node_549)))
                + ((current_base_row[220usize]) * (node_809)))
                + ((current_base_row[206usize]) * (node_531)))
                + ((current_base_row[225usize]) * (node_520)))
                + ((current_base_row[213usize]) * (node_128)))
                + ((current_base_row[223usize]) * (node_1235)))
                + ((current_base_row[218usize]) * (node_809)))
                + ((current_base_row[224usize]) * (node_484)))
                + ((current_base_row[230usize]) * (node_468)))
                + ((current_base_row[232usize]) * (node_468)))
                + ((current_base_row[228usize]) * (node_1236)))
                + ((current_base_row[229usize]) * (node_1236)))
                + ((current_base_row[235usize]) * (node_1234)))
                + ((current_base_row[237usize]) * (node_549)))
                + ((current_base_row[234usize]) * (node_1237)))
                + ((current_base_row[238usize]) * (node_1237)))
                + ((current_base_row[243usize]) * (node_1237)))
                + ((current_base_row[250usize]) * (node_1237)))
                + ((current_base_row[268usize]) * (node_1593)))
                + ((current_base_row[269usize]) * (node_1593)))
                + ((current_base_row[281usize]) * (node_520)))
                + ((current_base_row[282usize]) * (node_1240)))
                + ((current_base_row[275usize]) * (node_809)))
                + ((current_base_row[276usize]) * (node_484)))
                + ((current_base_row[298usize]) * (node_516)))
                + ((current_base_row[297usize]) * (node_1177)))
                + ((current_base_row[300usize]) * (node_524)))
                + ((current_base_row[301usize]) * (node_524))) * (node_3926))
                + ((node_524) * (next_base_row[8usize])),
            (((((((((((((((((((((((((((((current_base_row[216usize]) * (node_512))
                + ((current_base_row[205usize]) * (node_551)))
                + ((current_base_row[220usize]) * (node_512)))
                + ((current_base_row[206usize]) * (node_533)))
                + ((current_base_row[225usize]) * (node_524)))
                + ((current_base_row[213usize]) * (node_812)))
                + ((current_base_row[223usize]) * (node_1236)))
                + (current_ext_row[86usize])) + (current_ext_row[87usize]))
                + ((current_base_row[230usize]) * (node_516)))
                + ((current_base_row[232usize]) * (node_516)))
                + ((current_base_row[228usize]) * (node_1237)))
                + ((current_base_row[229usize]) * (node_1237)))
                + ((current_base_row[235usize]) * (node_1235)))
                + ((current_base_row[237usize]) * (node_551)))
                + ((current_base_row[234usize]) * (node_1238)))
                + ((current_base_row[238usize]) * (node_1238)))
                + ((current_base_row[243usize]) * (node_1238)))
                + ((current_base_row[250usize]) * (node_1238)))
                + ((current_base_row[268usize]) * (node_1594)))
                + ((current_base_row[269usize]) * (node_1594)))
                + ((current_base_row[281usize]) * (node_524)))
                + ((current_base_row[282usize]) * (node_1241)))
                + ((current_base_row[275usize])
                    * ((((((current_base_row[195usize])
                        * ((next_ext_row[3usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * ((node_2049) + (next_base_row[22usize])))))
                        + ((current_base_row[196usize])
                            * ((next_ext_row[3usize])
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (((challenges[1usize])
                                        * ((node_2049) + (next_base_row[23usize])))
                                        + (next_base_row[22usize]))))))
                        + ((current_base_row[197usize])
                            * ((next_ext_row[3usize])
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (((challenges[1usize])
                                        * (((challenges[1usize])
                                            * ((node_2049) + (next_base_row[24usize])))
                                            + (next_base_row[23usize]))) + (next_base_row[22usize]))))))
                        + ((current_base_row[198usize])
                            * ((next_ext_row[3usize])
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (((challenges[1usize])
                                        * (((challenges[1usize])
                                            * (((challenges[1usize])
                                                * ((node_2049) + (next_base_row[25usize])))
                                                + (next_base_row[24usize]))) + (next_base_row[23usize])))
                                        + (next_base_row[22usize]))))))
                        + ((current_base_row[199usize])
                            * ((next_ext_row[3usize])
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (((challenges[1usize])
                                        * (((challenges[1usize])
                                            * (((challenges[1usize])
                                                * (((challenges[1usize])
                                                    * ((node_2049) + (next_base_row[26usize])))
                                                    + (next_base_row[25usize]))) + (next_base_row[24usize])))
                                            + (next_base_row[23usize])))
                                        + (next_base_row[22usize]))))))))
                + ((current_base_row[276usize])
                    * ((((((current_base_row[195usize])
                        * ((next_ext_row[4usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (node_2096))))
                        + ((current_base_row[196usize])
                            * ((next_ext_row[4usize])
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (node_2101)))))
                        + ((current_base_row[197usize])
                            * ((next_ext_row[4usize])
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (node_2106)))))
                        + ((current_base_row[198usize])
                            * ((next_ext_row[4usize])
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (node_2111)))))
                        + ((current_base_row[199usize])
                            * ((next_ext_row[4usize])
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (((challenges[2usize]) * (node_2111))
                                        + (current_base_row[26usize]))))))))
                + ((current_base_row[297usize])
                    * (((((((((node_209) + (node_212)) + (node_215)) + (node_218))
                        + (node_221)) + (node_224)) + (node_227)) + (node_859))
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * ((((((((node_612) + (node_614)) + (node_616)) + (node_618))
                                + (node_620)) + (node_622)) + (node_624)) + (node_861))))))
                + ((current_base_row[300usize]) * (node_261)))
                + ((current_base_row[301usize]) * (node_261))) * (node_3926),
            (((((((((((((((((((((((((((current_base_row[216usize]) * (node_516))
                + ((current_base_row[205usize]) * (node_553)))
                + ((current_base_row[220usize]) * (node_516)))
                + ((current_base_row[206usize]) * (node_535)))
                + ((current_base_row[225usize]) * (node_261)))
                + ((current_base_row[213usize]) * (node_1230)))
                + ((current_base_row[223usize]) * (node_1237)))
                + ((current_base_row[218usize])
                    * ((((((current_base_row[195usize]) * (node_531))
                        + ((current_base_row[196usize])
                            * ((next_base_row[25usize]) + (node_530))))
                        + ((current_base_row[197usize])
                            * ((next_base_row[26usize]) + (node_530))))
                        + ((current_base_row[198usize])
                            * ((next_base_row[27usize]) + (node_530))))
                        + ((current_base_row[199usize])
                            * ((next_base_row[28usize]) + (node_530))))))
                + ((current_base_row[224usize])
                    * ((((((current_base_row[195usize]) * (node_1230))
                        + ((current_base_row[196usize])
                            * ((next_base_row[23usize]) + (node_534))))
                        + ((current_base_row[197usize])
                            * ((next_base_row[23usize]) + (node_536))))
                        + ((current_base_row[198usize])
                            * ((next_base_row[23usize]) + (node_538))))
                        + ((current_base_row[199usize])
                            * ((next_base_row[23usize]) + (node_540))))))
                + ((current_base_row[230usize]) * (node_520)))
                + ((current_base_row[232usize]) * (node_520)))
                + ((current_base_row[228usize]) * (node_1238)))
                + ((current_base_row[229usize]) * (node_1238)))
                + ((current_base_row[235usize]) * (node_1236)))
                + ((current_base_row[237usize]) * (node_553)))
                + ((current_base_row[234usize]) * (node_1239)))
                + ((current_base_row[238usize]) * (node_1239)))
                + ((current_base_row[243usize]) * (node_1239)))
                + ((current_base_row[250usize]) * (node_1239)))
                + ((current_base_row[268usize]) * (node_372)))
                + ((current_base_row[269usize]) * (node_372)))
                + ((current_base_row[282usize]) * (node_1242)))
                + ((current_base_row[275usize]) * (node_512)))
                + ((current_base_row[276usize]) * (node_512)))
                + ((current_base_row[300usize]) * (node_1177)))
                + ((current_base_row[301usize]) * (node_1177))) * (node_3926),
            (((((((((((((((((((((((((((current_base_row[216usize]) * (node_520))
                + ((current_base_row[205usize]) * (node_555)))
                + ((current_base_row[220usize]) * (node_520)))
                + ((current_base_row[206usize]) * (node_537)))
                + ((current_base_row[225usize]) * (node_1177)))
                + ((current_base_row[213usize]) * (node_1231)))
                + ((current_base_row[223usize]) * (node_1238)))
                + ((current_base_row[218usize])
                    * ((((((current_base_row[195usize]) * (node_533))
                        + ((current_base_row[196usize])
                            * ((next_base_row[26usize]) + (node_532))))
                        + ((current_base_row[197usize])
                            * ((next_base_row[27usize]) + (node_532))))
                        + ((current_base_row[198usize])
                            * ((next_base_row[28usize]) + (node_532))))
                        + ((current_base_row[199usize])
                            * ((next_base_row[29usize]) + (node_532))))))
                + ((current_base_row[224usize])
                    * ((((((current_base_row[195usize]) * (node_1231))
                        + ((current_base_row[196usize])
                            * ((next_base_row[24usize]) + (node_536))))
                        + ((current_base_row[197usize])
                            * ((next_base_row[24usize]) + (node_538))))
                        + ((current_base_row[198usize])
                            * ((next_base_row[24usize]) + (node_540))))
                        + ((current_base_row[199usize])
                            * ((next_base_row[24usize]) + (node_542))))))
                + ((current_base_row[230usize]) * (node_524)))
                + ((current_base_row[232usize]) * (node_524)))
                + ((current_base_row[228usize]) * (node_1239)))
                + ((current_base_row[229usize]) * (node_1239)))
                + ((current_base_row[235usize]) * (node_1237)))
                + ((current_base_row[237usize]) * (node_555)))
                + ((current_base_row[234usize]) * (node_1240)))
                + ((current_base_row[238usize]) * (node_1240)))
                + ((current_base_row[243usize]) * (node_1240)))
                + ((current_base_row[250usize]) * (node_1240)))
                + ((current_base_row[268usize]) * (node_385)))
                + ((current_base_row[269usize]) * (node_385)))
                + ((current_base_row[282usize]) * (node_1243)))
                + ((current_base_row[275usize]) * (node_516)))
                + ((current_base_row[276usize]) * (node_516)))
                + ((current_base_row[300usize]) * (node_1820)))
                + ((current_base_row[301usize]) * (node_1820))) * (node_3926),
            ((((((((((((((((((((((current_base_row[216usize]) * (node_524))
                + ((current_base_row[205usize]) * (node_557)))
                + ((current_base_row[220usize]) * (node_524)))
                + ((current_base_row[206usize]) * (node_539)))
                + ((current_base_row[213usize]) * (node_1232)))
                + ((current_base_row[223usize]) * (node_1239)))
                + ((current_base_row[218usize])
                    * ((((((current_base_row[195usize]) * (node_535))
                        + ((current_base_row[196usize])
                            * ((next_base_row[27usize]) + (node_534))))
                        + ((current_base_row[197usize])
                            * ((next_base_row[28usize]) + (node_534))))
                        + ((current_base_row[198usize])
                            * ((next_base_row[29usize]) + (node_534))))
                        + ((current_base_row[199usize])
                            * ((next_base_row[30usize]) + (node_534))))))
                + ((current_base_row[224usize])
                    * ((((((current_base_row[195usize]) * (node_1232))
                        + ((current_base_row[196usize])
                            * ((next_base_row[25usize]) + (node_538))))
                        + ((current_base_row[197usize]) * (node_1585)))
                        + ((current_base_row[198usize])
                            * ((next_base_row[25usize]) + (node_542))))
                        + ((current_base_row[199usize])
                            * ((next_base_row[25usize]) + (node_544))))))
                + ((current_base_row[228usize]) * (node_1240)))
                + ((current_base_row[229usize]) * (node_1240)))
                + ((current_base_row[235usize]) * (node_1238)))
                + ((current_base_row[237usize]) * (node_557)))
                + ((current_base_row[234usize]) * (node_1241)))
                + ((current_base_row[238usize]) * (node_1241)))
                + ((current_base_row[243usize]) * (node_1241)))
                + ((current_base_row[250usize]) * (node_1241)))
                + ((current_base_row[268usize]) * (node_120)))
                + ((current_base_row[269usize]) * (node_120)))
                + ((current_base_row[282usize]) * (node_262)))
                + ((current_base_row[275usize]) * (node_524)))
                + ((current_base_row[276usize]) * (node_520))) * (node_3926),
            ((((((((((((((((((current_base_row[205usize]) * (node_558))
                + ((current_base_row[206usize]) * (node_541)))
                + ((current_base_row[213usize]) * (node_1233)))
                + ((current_base_row[223usize]) * (node_1240)))
                + ((current_base_row[218usize])
                    * ((((((current_base_row[195usize]) * (node_537))
                        + ((current_base_row[196usize])
                            * ((next_base_row[28usize]) + (node_536))))
                        + ((current_base_row[197usize])
                            * ((next_base_row[29usize]) + (node_536))))
                        + ((current_base_row[198usize])
                            * ((next_base_row[30usize]) + (node_536))))
                        + ((current_base_row[199usize])
                            * ((next_base_row[31usize]) + (node_536))))))
                + ((current_base_row[224usize])
                    * ((((((current_base_row[195usize]) * (node_1233))
                        + ((current_base_row[196usize])
                            * ((next_base_row[26usize]) + (node_540))))
                        + ((current_base_row[197usize]) * (node_1586)))
                        + ((current_base_row[198usize])
                            * ((next_base_row[26usize]) + (node_544))))
                        + ((current_base_row[199usize])
                            * ((next_base_row[26usize]) + (node_546))))))
                + ((current_base_row[228usize]) * (node_1241)))
                + ((current_base_row[229usize]) * (node_1241)))
                + ((current_base_row[235usize]) * (node_1239)))
                + ((current_base_row[237usize]) * (node_558)))
                + ((current_base_row[234usize]) * (node_1242)))
                + ((current_base_row[238usize]) * (node_1242)))
                + ((current_base_row[243usize]) * (node_1242)))
                + ((current_base_row[250usize]) * (node_1242)))
                + ((current_base_row[268usize]) * (node_124)))
                + ((current_base_row[269usize]) * (node_124)))
                + ((current_base_row[282usize]) * (node_286))) * (node_3926),
            ((((((((((((((((((current_base_row[205usize]) * (node_567))
                + ((current_base_row[206usize]) * (node_543)))
                + ((current_base_row[213usize]) * (node_1234)))
                + ((current_base_row[223usize]) * (node_1241)))
                + ((current_base_row[218usize])
                    * ((((((current_base_row[195usize]) * (node_539))
                        + ((current_base_row[196usize])
                            * ((next_base_row[29usize]) + (node_538))))
                        + ((current_base_row[197usize])
                            * ((next_base_row[30usize]) + (node_538))))
                        + ((current_base_row[198usize])
                            * ((next_base_row[31usize]) + (node_538))))
                        + ((current_base_row[199usize])
                            * ((next_base_row[32usize]) + (node_538))))))
                + ((current_base_row[224usize])
                    * ((((((current_base_row[195usize]) * (node_1234))
                        + ((current_base_row[196usize])
                            * ((next_base_row[27usize]) + (node_542))))
                        + ((current_base_row[197usize]) * (node_1587)))
                        + ((current_base_row[198usize])
                            * ((next_base_row[27usize]) + (node_546))))
                        + ((current_base_row[199usize]) * (node_1661)))))
                + ((current_base_row[228usize]) * (node_1242)))
                + ((current_base_row[229usize]) * (node_1242)))
                + ((current_base_row[235usize]) * (node_1240)))
                + ((current_base_row[237usize]) * (node_567)))
                + ((current_base_row[234usize]) * (node_1243)))
                + ((current_base_row[238usize]) * (node_1243)))
                + ((current_base_row[243usize]) * (node_1243)))
                + ((current_base_row[250usize]) * (node_1243)))
                + ((current_base_row[268usize]) * (node_128)))
                + ((current_base_row[269usize]) * (node_128)))
                + ((current_base_row[282usize]) * (node_120))) * (node_3926),
            ((((((((((((((((((current_base_row[205usize]) * (node_124))
                + ((current_base_row[206usize]) * (node_547)))
                + ((current_base_row[213usize]) * (node_1236)))
                + ((current_base_row[223usize]) * (node_1243)))
                + ((current_base_row[218usize])
                    * ((((((current_base_row[195usize]) * (node_543))
                        + ((current_base_row[196usize])
                            * ((next_base_row[31usize]) + (node_542))))
                        + ((current_base_row[197usize])
                            * ((next_base_row[32usize]) + (node_542))))
                        + ((current_base_row[198usize])
                            * ((next_base_row[33usize]) + (node_542))))
                        + ((current_base_row[199usize])
                            * ((next_base_row[34usize]) + (node_542))))))
                + ((current_base_row[224usize])
                    * ((((((current_base_row[195usize]) * (node_1236))
                        + ((current_base_row[196usize])
                            * ((next_base_row[29usize]) + (node_546))))
                        + ((current_base_row[197usize]) * (node_1589)))
                        + ((current_base_row[198usize])
                            * ((next_base_row[29usize]) + (node_550))))
                        + ((current_base_row[199usize]) * (node_1663)))))
                + ((current_base_row[228usize]) * (node_262)))
                + ((current_base_row[229usize]) * (node_262)))
                + ((current_base_row[235usize]) * (node_1242)))
                + ((current_base_row[237usize]) * (node_124)))
                + ((current_base_row[234usize]) * (node_286)))
                + ((current_base_row[238usize]) * (node_286)))
                + ((current_base_row[243usize]) * (node_286)))
                + ((current_base_row[250usize]) * (node_286)))
                + ((current_base_row[268usize]) * (node_516)))
                + ((current_base_row[269usize]) * (node_516)))
                + ((current_base_row[282usize]) * (node_128))) * (node_3926),
            ((((((((((((((((((current_base_row[205usize]) * (node_128))
                + ((current_base_row[206usize]) * (node_549)))
                + ((current_base_row[213usize]) * (node_1237)))
                + ((current_base_row[223usize]) * (node_262)))
                + ((current_base_row[218usize])
                    * ((((((current_base_row[195usize]) * (node_545))
                        + ((current_base_row[196usize])
                            * ((next_base_row[32usize]) + (node_544))))
                        + ((current_base_row[197usize])
                            * ((next_base_row[33usize]) + (node_544))))
                        + ((current_base_row[198usize])
                            * ((next_base_row[34usize]) + (node_544))))
                        + ((current_base_row[199usize])
                            * ((next_base_row[35usize]) + (node_544))))))
                + ((current_base_row[224usize])
                    * ((((((current_base_row[195usize]) * (node_1237))
                        + ((current_base_row[196usize])
                            * ((next_base_row[30usize]) + (node_548))))
                        + ((current_base_row[197usize]) * (node_1590)))
                        + ((current_base_row[198usize])
                            * ((next_base_row[30usize]) + (node_552))))
                        + ((current_base_row[199usize]) * (node_1664)))))
                + ((current_base_row[228usize]) * (node_286)))
                + ((current_base_row[229usize]) * (node_286)))
                + ((current_base_row[235usize]) * (node_1243)))
                + ((current_base_row[237usize]) * (node_128)))
                + ((current_base_row[234usize]) * (node_516)))
                + ((current_base_row[238usize]) * (node_516)))
                + ((current_base_row[243usize]) * (node_516)))
                + ((current_base_row[250usize]) * (node_516)))
                + ((current_base_row[268usize]) * (node_520)))
                + ((current_base_row[269usize]) * (node_520)))
                + ((current_base_row[282usize]) * (node_1182))) * (node_3926),
            ((((((((((((((((((current_base_row[205usize]) * (node_116))
                + ((current_base_row[206usize]) * (node_551)))
                + ((current_base_row[213usize]) * (node_1238)))
                + ((current_base_row[223usize]) * (node_286)))
                + ((current_base_row[218usize])
                    * ((((((current_base_row[195usize]) * (node_547))
                        + ((current_base_row[196usize])
                            * ((next_base_row[33usize]) + (node_546))))
                        + ((current_base_row[197usize])
                            * ((next_base_row[34usize]) + (node_546))))
                        + ((current_base_row[198usize])
                            * ((next_base_row[35usize]) + (node_546))))
                        + ((current_base_row[199usize])
                            * ((next_base_row[36usize]) + (node_546))))))
                + ((current_base_row[224usize])
                    * ((((((current_base_row[195usize]) * (node_1238))
                        + ((current_base_row[196usize])
                            * ((next_base_row[31usize]) + (node_550))))
                        + ((current_base_row[197usize]) * (node_1591)))
                        + ((current_base_row[198usize])
                            * ((next_base_row[31usize]) + (node_554))))
                        + ((current_base_row[199usize]) * (node_1665)))))
                + ((current_base_row[228usize]) * (node_516)))
                + ((current_base_row[229usize]) * (node_516)))
                + ((current_base_row[235usize]) * (node_262)))
                + ((current_base_row[237usize]) * (node_1182)))
                + ((current_base_row[234usize]) * (node_520)))
                + ((current_base_row[238usize]) * (node_520)))
                + ((current_base_row[243usize]) * (node_520)))
                + ((current_base_row[250usize]) * (node_520)))
                + ((current_base_row[268usize]) * (node_524)))
                + ((current_base_row[269usize]) * (node_524)))
                + ((current_base_row[282usize]) * (node_516))) * (node_3926),
            ((((((((((((((((current_base_row[205usize]) * (node_516))
                + ((current_base_row[206usize]) * (node_553)))
                + ((current_base_row[213usize]) * (node_1239)))
                + ((current_base_row[223usize]) * (node_516)))
                + ((current_base_row[218usize])
                    * ((((((current_base_row[195usize]) * (node_549))
                        + ((current_base_row[196usize])
                            * ((next_base_row[34usize]) + (node_548))))
                        + ((current_base_row[197usize])
                            * ((next_base_row[35usize]) + (node_548))))
                        + ((current_base_row[198usize])
                            * ((next_base_row[36usize]) + (node_548))))
                        + ((current_base_row[199usize])
                            * ((next_base_row[37usize]) + (node_548))))))
                + ((current_base_row[224usize])
                    * ((((((current_base_row[195usize]) * (node_1239))
                        + ((current_base_row[196usize])
                            * ((next_base_row[32usize]) + (node_552))))
                        + ((current_base_row[197usize]) * (node_1592)))
                        + ((current_base_row[198usize])
                            * ((next_base_row[32usize]) + (node_556))))
                        + ((current_base_row[199usize]) * (node_1666)))))
                + ((current_base_row[228usize]) * (node_520)))
                + ((current_base_row[229usize]) * (node_520)))
                + ((current_base_row[235usize]) * (node_286)))
                + ((current_base_row[237usize]) * (node_516)))
                + ((current_base_row[234usize]) * (node_524)))
                + ((current_base_row[238usize]) * (node_524)))
                + ((current_base_row[243usize]) * (node_524)))
                + ((current_base_row[250usize]) * (node_524)))
                + ((current_base_row[282usize]) * (node_520))) * (node_3926),
            ((((((((((((current_base_row[205usize]) * (node_520))
                + ((current_base_row[206usize]) * (node_555)))
                + ((current_base_row[213usize]) * (node_1240)))
                + ((current_base_row[223usize]) * (node_520)))
                + ((current_base_row[218usize])
                    * (((((current_base_row[195usize]) * (node_551))
                        + ((current_base_row[196usize])
                            * ((next_base_row[35usize]) + (node_550))))
                        + ((current_base_row[197usize])
                            * ((next_base_row[36usize]) + (node_550))))
                        + ((current_base_row[198usize])
                            * ((next_base_row[37usize]) + (node_550))))))
                + ((current_base_row[224usize])
                    * (((((current_base_row[195usize]) * (node_1240))
                        + ((current_base_row[196usize])
                            * ((next_base_row[33usize]) + (node_554))))
                        + ((current_base_row[197usize]) * (node_1593)))
                        + ((current_base_row[198usize])
                            * ((next_base_row[33usize]) + (node_854))))))
                + ((current_base_row[228usize]) * (node_524)))
                + ((current_base_row[229usize]) * (node_524)))
                + ((current_base_row[235usize]) * (node_516)))
                + ((current_base_row[237usize]) * (node_520)))
                + ((current_base_row[282usize]) * (node_524))) * (node_3926),
            (((((((((current_base_row[205usize]) * (node_524))
                + ((current_base_row[206usize]) * (node_557)))
                + ((current_base_row[213usize]) * (node_1241)))
                + ((current_base_row[223usize]) * (node_524)))
                + ((current_base_row[218usize])
                    * ((((current_base_row[195usize]) * (node_553))
                        + ((current_base_row[196usize])
                            * ((next_base_row[36usize]) + (node_552))))
                        + ((current_base_row[197usize])
                            * ((next_base_row[37usize]) + (node_552))))))
                + ((current_base_row[224usize])
                    * ((((current_base_row[195usize]) * (node_1241))
                        + ((current_base_row[196usize])
                            * ((next_base_row[34usize]) + (node_556))))
                        + ((current_base_row[197usize]) * (node_1594)))))
                + ((current_base_row[235usize]) * (node_520)))
                + ((current_base_row[237usize]) * (node_524))) * (node_3926),
            ((((((current_base_row[206usize]) * (node_558))
                + ((current_base_row[213usize]) * (node_1242)))
                + ((current_base_row[218usize])
                    * (((current_base_row[195usize]) * (node_555))
                        + ((current_base_row[196usize])
                            * ((next_base_row[37usize]) + (node_554))))))
                + ((current_base_row[224usize])
                    * (((current_base_row[195usize]) * (node_1242))
                        + ((current_base_row[196usize])
                            * ((next_base_row[35usize]) + (node_854))))))
                + ((current_base_row[235usize]) * (node_524))) * (node_3926),
            (((((current_base_row[206usize]) * (node_567))
                + ((current_base_row[213usize]) * (node_1243)))
                + ((current_base_row[218usize])
                    * ((current_base_row[195usize]) * (node_557))))
                + ((current_base_row[224usize])
                    * ((current_base_row[195usize]) * (node_1243)))) * (node_3926),
            (((((current_base_row[206usize]) * (node_516))
                + ((current_base_row[213usize]) * (node_262)))
                + ((current_base_row[218usize]) * (node_512)))
                + ((current_base_row[224usize]) * (node_512))) * (node_3926),
            (((((current_base_row[206usize]) * (node_520))
                + ((current_base_row[213usize]) * (node_286)))
                + ((current_base_row[218usize]) * (node_520)))
                + ((current_base_row[224usize]) * (node_520))) * (node_3926),
            (((((current_base_row[206usize]) * (node_524))
                + ((current_base_row[213usize]) * (node_516)))
                + ((current_base_row[218usize]) * (node_524)))
                + ((current_base_row[224usize]) * (node_524))) * (node_3926),
            ((current_base_row[213usize]) * (node_520)) * (node_3926),
            ((current_base_row[213usize]) * (node_524)) * (node_3926),
            (((next_ext_row[13usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (current_ext_row[13usize])))
                * ((challenges[11usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (next_base_row[7usize]))))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (next_base_row[45usize])),
            ((node_3926)
                * (((node_4002)
                    * ((challenges[3usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * ((((challenges[13usize]) * (next_base_row[9usize]))
                                + ((challenges[14usize]) * (next_base_row[10usize])))
                                + ((challenges[15usize]) * (next_base_row[11usize]))))))
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                + ((next_base_row[8usize]) * (node_4002)),
            (next_ext_row[8usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_ext_row[8usize])
                        * ((challenges[9usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * ((((((challenges[24usize]) * (next_base_row[7usize]))
                                    + ((challenges[25usize]) * (next_base_row[10usize])))
                                    + ((challenges[26usize]) * (next_base_row[19usize])))
                                    + ((challenges[27usize]) * (next_base_row[20usize])))
                                    + ((challenges[28usize]) * (next_base_row[21usize]))))))),
            (((((((next_base_row[10usize])
                + (BFieldElement::from_raw_u64(18446743992105173011u64)))
                * ((next_base_row[10usize])
                    + (BFieldElement::from_raw_u64(18446743914795761701u64))))
                * ((next_base_row[10usize])
                    + (BFieldElement::from_raw_u64(18446743880436023341u64))))
                * ((next_ext_row[9usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_ext_row[9usize]))))
                + ((current_base_row[352usize]) * ((node_4138) + (node_4139))))
                + (((current_base_row[353usize]) * (node_4048)) * (node_4144)))
                + (((current_base_row[355usize]) * (node_4048)) * (node_4144)),
            (((((current_base_row[10usize])
                + (BFieldElement::from_raw_u64(18446743992105173011u64)))
                * ((current_base_row[10usize])
                    + (BFieldElement::from_raw_u64(18446743914795761701u64))))
                * ((current_base_row[10usize])
                    + (BFieldElement::from_raw_u64(18446743880436023341u64))))
                * ((next_ext_row[10usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_ext_row[10usize]))))
                + ((((current_base_row[230usize]) + (current_base_row[298usize]))
                    + (current_base_row[297usize]))
                    * (((next_ext_row[10usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * ((challenges[5usize]) * (current_ext_row[10usize]))))
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (node_198)))),
            (((((current_base_row[330usize])
                * ((next_ext_row[11usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_ext_row[11usize]))))
                + ((current_base_row[257usize]) * (node_4193)))
                + ((current_base_row[258usize])
                    * ((node_4193)
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (node_615)))))
                + ((current_base_row[260usize])
                    * (((node_4189)
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * ((challenges[31usize])
                                * (BFieldElement::from_raw_u64(146028888030u64)))))
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((((((node_574)
                                + ((challenges[36usize]) * (current_base_row[39usize])))
                                + ((challenges[37usize]) * (current_base_row[40usize])))
                                + ((challenges[38usize]) * (current_base_row[41usize])))
                                + ((challenges[39usize]) * (current_base_row[42usize])))
                                + ((challenges[40usize]) * (current_base_row[43usize])))
                                + ((challenges[41usize]) * (current_base_row[44usize])))))))
                + ((current_base_row[262usize]) * ((node_4193) + (node_4139))),
            (((((((((((current_base_row[237usize])
                * (((node_4282) * (((node_4232) + (node_4235)) + (node_4239)))
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                + ((current_base_row[234usize]) * (node_4286)))
                + ((current_base_row[238usize]) * (node_4286)))
                + ((current_base_row[243usize])
                    * (((node_4282)
                        * (((node_4246)
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * ((challenges[57usize])
                                    * (BFieldElement::from_raw_u64(60129542130u64)))))
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((challenges[58usize])
                                    * (((current_base_row[22usize])
                                        + (current_base_row[23usize])) + (node_1937)))
                                    * (BFieldElement::from_raw_u64(9223372036854775808u64))))))
                        + (BFieldElement::from_raw_u64(18446744065119617026u64)))))
                + ((current_base_row[250usize]) * (node_4286)))
                + ((current_base_row[270usize]) * (node_4290)))
                + ((current_base_row[266usize])
                    * (((((node_4282) * (node_4269)) * (node_4273))
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (node_4269)))
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (node_4273)))))
                + ((current_base_row[273usize]) * (node_4290)))
                + ((current_base_row[298usize]) * (node_4292)))
                + ((current_base_row[297usize]) * (node_4292)))
                + (((BFieldElement::from_raw_u64(4294967295u64))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_base_row[14usize]))) * (node_4282)),
            (((next_ext_row[14usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_ext_row[14usize])
                        * ((challenges[7usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((((challenges[16usize]) * (next_base_row[46usize]))
                                    + ((challenges[17usize]) * (next_base_row[47usize])))
                                    + ((challenges[18usize]) * (next_base_row[48usize])))
                                    + ((challenges[19usize]) * (next_base_row[49usize]))))))))
                * (node_4342))
                + (((next_ext_row[14usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_ext_row[14usize]))) * (node_4359)),
            ((((((node_4368)
                * ((challenges[11usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((next_base_row[46usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (current_base_row[46usize]))))))
                + (BFieldElement::from_raw_u64(18446744065119617026u64))) * (node_4336))
                * (node_4342)) + ((node_4368) * (node_4335)))
                + ((node_4368) * (node_4359)),
            ((node_4410)
                * ((next_ext_row[16usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((current_ext_row[16usize]) * (node_4428)))))
                + ((node_4413) * ((next_ext_row[16usize]) + (node_4433))),
            ((node_4410)
                * (((next_ext_row[17usize]) + (node_4433))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((node_4428) * (current_ext_row[17usize])))))
                + ((node_4413)
                    * ((next_ext_row[17usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (current_ext_row[17usize])))),
            ((node_4410)
                * (((next_ext_row[18usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((challenges[12usize]) * (current_ext_row[18usize]))))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (next_base_row[55usize]))))
                + ((node_4413)
                    * ((next_ext_row[18usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (current_ext_row[18usize])))),
            ((node_4410)
                * (((next_ext_row[19usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((challenges[12usize]) * (current_ext_row[19usize]))))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (next_base_row[56usize]))))
                + ((node_4413)
                    * ((next_ext_row[19usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (current_ext_row[19usize])))),
            (((next_ext_row[20usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_ext_row[20usize])
                        * ((challenges[8usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((((next_base_row[50usize]) * (challenges[20usize]))
                                    + ((next_base_row[52usize]) * (challenges[21usize])))
                                    + ((next_base_row[53usize]) * (challenges[22usize])))
                                    + ((next_base_row[51usize]) * (challenges[23usize]))))))))
                * (node_4405))
                + (((next_ext_row[20usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_ext_row[20usize]))) * (node_4479)),
            (((current_ext_row[84usize]) * (node_4405)) + ((node_4488) * (node_4410)))
                + ((node_4488) * (node_4479)),
            (next_ext_row[22usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_ext_row[22usize])
                        * ((challenges[9usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * ((((((challenges[24usize]) * (next_base_row[57usize]))
                                    + ((challenges[25usize]) * (next_base_row[58usize])))
                                    + ((challenges[26usize]) * (next_base_row[59usize])))
                                    + ((challenges[27usize]) * (next_base_row[60usize])))
                                    + ((challenges[28usize]) * (next_base_row[61usize]))))))),
            ((node_4517)
                * (((node_4553)
                    * ((challenges[11usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (node_4532))))
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                + ((node_4516) * (node_4553)),
            (((current_base_row[356usize])
                * (((next_ext_row[24usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((challenges[30usize]) * (current_ext_row[24usize]))))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((((((((((((((((((((challenges[29usize]) + (node_5306))
                            * (challenges[29usize])) + (node_5317))
                            * (challenges[29usize])) + (node_5328))
                            * (challenges[29usize])) + (node_5339))
                            * (challenges[29usize])) + (next_base_row[97usize]))
                            * (challenges[29usize])) + (next_base_row[98usize]))
                            * (challenges[29usize])) + (next_base_row[99usize]))
                            * (challenges[29usize])) + (next_base_row[100usize]))
                            * (challenges[29usize])) + (next_base_row[101usize]))
                            * (challenges[29usize])) + (next_base_row[102usize])))))
                + ((next_base_row[64usize]) * (node_5642)))
                + ((node_5430) * (node_5642)),
            ((current_base_row[357usize]) * (node_5430))
                * (((((((((((challenges[0usize]) + (node_4590)) * (challenges[0usize]))
                    + (node_4601)) * (challenges[0usize])) + (node_4612))
                    * (challenges[0usize])) + (node_4623)) * (challenges[0usize]))
                    + (current_base_row[97usize]))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (challenges[62usize]))),
            (current_base_row[371usize])
                * ((((((node_5473) + (node_5474)) + (node_5476)) + (node_5478))
                    + (node_5480)) + (node_5482)),
            (current_base_row[372usize])
                * (((((((((((((((((challenges[32usize])
                    * ((node_5306)
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (node_4590))))
                    + ((challenges[33usize])
                        * ((node_5317)
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (node_4601)))))
                    + ((challenges[34usize])
                        * ((node_5328)
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (node_4612)))))
                    + ((challenges[35usize])
                        * ((node_5339)
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (node_4623)))))
                    + ((challenges[36usize])
                        * ((next_base_row[97usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (current_base_row[97usize])))))
                    + ((challenges[37usize])
                        * ((next_base_row[98usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (current_base_row[98usize])))))
                    + ((challenges[38usize])
                        * ((next_base_row[99usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (current_base_row[99usize])))))
                    + ((challenges[39usize])
                        * ((next_base_row[100usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (current_base_row[100usize])))))
                    + ((challenges[40usize])
                        * ((next_base_row[101usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (current_base_row[101usize])))))
                    + ((challenges[41usize])
                        * ((next_base_row[102usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (current_base_row[102usize]))))) + (node_5473))
                    + (node_5474)) + (node_5476)) + (node_5478)) + (node_5480))
                    + (node_5482)),
            ((((current_base_row[320usize]) * (current_base_row[326usize]))
                * (((next_ext_row[25usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((challenges[4usize]) * (current_ext_row[25usize]))))
                    + (node_5572))) + ((next_base_row[64usize]) * (node_5549)))
                + ((node_5435) * (node_5549)),
            ((((node_5592) * (current_base_row[326usize]))
                * (((next_ext_row[26usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((challenges[5usize]) * (current_ext_row[26usize]))))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (node_5558)))) + ((node_5491) * (node_5583)))
                + ((node_5435) * (node_5583)),
            ((((current_base_row[320usize]) * (node_5542))
                * ((((next_ext_row[27usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((challenges[6usize]) * (current_ext_row[27usize]))))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((challenges[31usize]) * (next_base_row[63usize]))))
                    + (node_5572))) + ((next_base_row[64usize]) * (node_5609)))
                + ((((node_5439) * (node_5544)) * (node_5612)) * (node_5609)),
            (((current_base_row[296usize])
                * (((node_5661)
                    * ((challenges[48usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((challenges[49usize]) * (next_base_row[65usize]))
                                + ((challenges[50usize]) * (next_base_row[81usize]))))))
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                + ((node_5592) * (node_5661))) + ((node_5669) * (node_5661)),
            (((current_base_row[296usize])
                * (((node_5682)
                    * ((challenges[48usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((challenges[49usize]) * (next_base_row[66usize]))
                                + ((challenges[50usize]) * (next_base_row[82usize]))))))
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                + ((node_5592) * (node_5682))) + ((node_5669) * (node_5682)),
            (((current_base_row[296usize])
                * (((node_5699)
                    * ((challenges[48usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((challenges[49usize]) * (next_base_row[67usize]))
                                + ((challenges[50usize]) * (next_base_row[83usize]))))))
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                + ((node_5592) * (node_5699))) + ((node_5669) * (node_5699)),
            (((current_base_row[296usize])
                * (((node_5716)
                    * ((challenges[48usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((challenges[49usize]) * (next_base_row[68usize]))
                                + ((challenges[50usize]) * (next_base_row[84usize]))))))
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                + ((node_5592) * (node_5716))) + ((node_5669) * (node_5716)),
            (((current_base_row[296usize])
                * (((node_5733)
                    * ((challenges[48usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((challenges[49usize]) * (next_base_row[69usize]))
                                + ((challenges[50usize]) * (next_base_row[85usize]))))))
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                + ((node_5592) * (node_5733))) + ((node_5669) * (node_5733)),
            (((current_base_row[296usize])
                * (((node_5750)
                    * ((challenges[48usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((challenges[49usize]) * (next_base_row[70usize]))
                                + ((challenges[50usize]) * (next_base_row[86usize]))))))
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                + ((node_5592) * (node_5750))) + ((node_5669) * (node_5750)),
            (((current_base_row[296usize])
                * (((node_5767)
                    * ((challenges[48usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((challenges[49usize]) * (next_base_row[71usize]))
                                + ((challenges[50usize]) * (next_base_row[87usize]))))))
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                + ((node_5592) * (node_5767))) + ((node_5669) * (node_5767)),
            (((current_base_row[296usize])
                * (((node_5784)
                    * ((challenges[48usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((challenges[49usize]) * (next_base_row[72usize]))
                                + ((challenges[50usize]) * (next_base_row[88usize]))))))
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                + ((node_5592) * (node_5784))) + ((node_5669) * (node_5784)),
            (((current_base_row[296usize])
                * (((node_5801)
                    * ((challenges[48usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((challenges[49usize]) * (next_base_row[73usize]))
                                + ((challenges[50usize]) * (next_base_row[89usize]))))))
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                + ((node_5592) * (node_5801))) + ((node_5669) * (node_5801)),
            (((current_base_row[296usize])
                * (((node_5818)
                    * ((challenges[48usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((challenges[49usize]) * (next_base_row[74usize]))
                                + ((challenges[50usize]) * (next_base_row[90usize]))))))
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                + ((node_5592) * (node_5818))) + ((node_5669) * (node_5818)),
            (((current_base_row[296usize])
                * (((node_5835)
                    * ((challenges[48usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((challenges[49usize]) * (next_base_row[75usize]))
                                + ((challenges[50usize]) * (next_base_row[91usize]))))))
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                + ((node_5592) * (node_5835))) + ((node_5669) * (node_5835)),
            (((current_base_row[296usize])
                * (((node_5852)
                    * ((challenges[48usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((challenges[49usize]) * (next_base_row[76usize]))
                                + ((challenges[50usize]) * (next_base_row[92usize]))))))
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                + ((node_5592) * (node_5852))) + ((node_5669) * (node_5852)),
            (((current_base_row[296usize])
                * (((node_5869)
                    * ((challenges[48usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((challenges[49usize]) * (next_base_row[77usize]))
                                + ((challenges[50usize]) * (next_base_row[93usize]))))))
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                + ((node_5592) * (node_5869))) + ((node_5669) * (node_5869)),
            (((current_base_row[296usize])
                * (((node_5886)
                    * ((challenges[48usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((challenges[49usize]) * (next_base_row[78usize]))
                                + ((challenges[50usize]) * (next_base_row[94usize]))))))
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                + ((node_5592) * (node_5886))) + ((node_5669) * (node_5886)),
            (((current_base_row[296usize])
                * (((node_5903)
                    * ((challenges[48usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((challenges[49usize]) * (next_base_row[79usize]))
                                + ((challenges[50usize]) * (next_base_row[95usize]))))))
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                + ((node_5592) * (node_5903))) + ((node_5669) * (node_5903)),
            (((current_base_row[296usize])
                * (((node_5920)
                    * ((challenges[48usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((challenges[49usize]) * (next_base_row[80usize]))
                                + ((challenges[50usize]) * (next_base_row[96usize]))))))
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                + ((node_5592) * (node_5920))) + ((node_5669) * (node_5920)),
            ((node_5946)
                * (((node_5956)
                    * ((challenges[48usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((challenges[49usize])
                                * (((BFieldElement::from_raw_u64(1099511627520u64))
                                    * (next_base_row[130usize])) + (next_base_row[131usize])))
                                + ((challenges[50usize])
                                    * (((BFieldElement::from_raw_u64(1099511627520u64))
                                        * (next_base_row[132usize]))
                                        + (next_base_row[133usize])))))))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (next_base_row[134usize]))))
                + ((next_base_row[129usize]) * (node_5956)),
            ((node_5946)
                * ((((((node_5972)
                    * ((challenges[51usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (node_5967))))
                    * ((challenges[51usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (node_5970))))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((BFieldElement::from_raw_u64(8589934590u64))
                            * (challenges[51usize])))) + (node_5967)) + (node_5970)))
                + ((next_base_row[129usize]) * (node_5972)),
            ((node_5998)
                * (((node_6010)
                    * ((challenges[51usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((next_base_row[136usize]) * (challenges[52usize]))
                                + ((next_base_row[137usize]) * (challenges[53usize]))))))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (next_base_row[138usize]))))
                + ((next_base_row[135usize]) * (node_6010)),
            ((node_5998)
                * (((next_ext_row[47usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((current_ext_row[47usize]) * (challenges[54usize]))))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (next_base_row[137usize]))))
                + ((next_base_row[135usize])
                    * ((next_ext_row[47usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (current_ext_row[47usize])))),
            (node_6058) * (node_6174),
            (next_base_row[139usize])
                * (((node_6174)
                    * ((challenges[10usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((((challenges[57usize]) * (next_base_row[142usize]))
                                + ((challenges[55usize]) * (next_base_row[143usize])))
                                + ((challenges[56usize]) * (next_base_row[145usize])))
                                + ((challenges[58usize]) * (next_base_row[147usize]))))))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (next_base_row[148usize]))),
            (current_ext_row[50usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_281)
                        * ((challenges[7usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_272)
                                    + ((challenges[18usize])
                                        * ((next_base_row[38usize])
                                            + (BFieldElement::from_raw_u64(4294967295u64)))))
                                    + ((challenges[19usize]) * (next_base_row[36usize]))))))),
            (current_ext_row[51usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_564)
                        * ((challenges[7usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_272)
                                    + ((challenges[18usize])
                                        * ((current_base_row[38usize])
                                            + (BFieldElement::from_raw_u64(4294967295u64)))))
                                    + ((challenges[19usize])
                                        * (current_base_row[36usize]))))))),
            (current_ext_row[52usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_ext_row[50usize])
                        * ((challenges[7usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_272)
                                    + ((challenges[18usize])
                                        * ((next_base_row[38usize])
                                            + (BFieldElement::from_raw_u64(8589934590u64)))))
                                    + ((challenges[19usize]) * (next_base_row[35usize]))))))),
            (current_ext_row[53usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_ext_row[51usize])
                        * ((challenges[7usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_272)
                                    + ((challenges[18usize])
                                        * ((current_base_row[38usize])
                                            + (BFieldElement::from_raw_u64(8589934590u64)))))
                                    + ((challenges[19usize])
                                        * (current_base_row[35usize]))))))),
            (current_ext_row[54usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_ext_row[52usize])
                        * ((challenges[7usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_272)
                                    + ((challenges[18usize])
                                        * ((next_base_row[38usize])
                                            + (BFieldElement::from_raw_u64(12884901885u64)))))
                                    + ((challenges[19usize]) * (next_base_row[34usize]))))))),
            (current_ext_row[55usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_ext_row[53usize])
                        * ((challenges[7usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_272)
                                    + ((challenges[18usize])
                                        * ((current_base_row[38usize])
                                            + (BFieldElement::from_raw_u64(12884901885u64)))))
                                    + ((challenges[19usize])
                                        * (current_base_row[34usize]))))))),
            (current_ext_row[56usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_ext_row[54usize])
                        * ((challenges[7usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_272)
                                    + ((challenges[18usize])
                                        * ((next_base_row[38usize])
                                            + (BFieldElement::from_raw_u64(17179869180u64)))))
                                    + ((challenges[19usize]) * (next_base_row[33usize]))))))),
            (current_ext_row[57usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_1283)
                        * ((challenges[8usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_1274)
                                    + (((next_base_row[22usize])
                                        + (BFieldElement::from_raw_u64(8589934590u64)))
                                        * (challenges[21usize])))
                                    + ((next_base_row[24usize]) * (challenges[22usize]))))))),
            (current_ext_row[58usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_1511)
                        * ((challenges[8usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_1272) + (node_1533))
                                    + ((current_base_row[24usize])
                                        * (challenges[22usize]))))))),
            (current_ext_row[59usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_ext_row[6usize]) * (current_ext_row[56usize]))),
            (current_ext_row[60usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_ext_row[55usize])
                        * ((challenges[7usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_272)
                                    + ((challenges[18usize])
                                        * ((current_base_row[38usize])
                                            + (BFieldElement::from_raw_u64(17179869180u64)))))
                                    + ((challenges[19usize])
                                        * (current_base_row[33usize]))))))),
            (current_ext_row[61usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_ext_row[57usize])
                        * ((challenges[8usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_1274)
                                    + (((next_base_row[22usize])
                                        + (BFieldElement::from_raw_u64(12884901885u64)))
                                        * (challenges[21usize])))
                                    + ((next_base_row[25usize]) * (challenges[22usize]))))))),
            (current_ext_row[62usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_ext_row[58usize])
                        * ((challenges[8usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_1272) + (node_1573))
                                    + ((current_base_row[25usize])
                                        * (challenges[22usize]))))))),
            (current_ext_row[63usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_ext_row[61usize])
                        * ((challenges[8usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_1274)
                                    + (((next_base_row[22usize])
                                        + (BFieldElement::from_raw_u64(17179869180u64)))
                                        * (challenges[21usize])))
                                    + ((next_base_row[26usize]) * (challenges[22usize]))))))),
            (current_ext_row[64usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_ext_row[62usize])
                        * ((challenges[8usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_1272)
                                    + (((current_base_row[22usize])
                                        + (BFieldElement::from_raw_u64(12884901885u64)))
                                        * (challenges[21usize])))
                                    + ((current_base_row[26usize])
                                        * (challenges[22usize]))))))),
            (current_ext_row[65usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_ext_row[56usize])
                        * ((challenges[7usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_272)
                                    + ((challenges[18usize])
                                        * ((next_base_row[38usize])
                                            + (BFieldElement::from_raw_u64(21474836475u64)))))
                                    + ((challenges[19usize]) * (next_base_row[32usize]))))))
                        * ((challenges[7usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_272)
                                    + ((challenges[18usize])
                                        * ((next_base_row[38usize])
                                            + (BFieldElement::from_raw_u64(25769803770u64)))))
                                    + ((challenges[19usize]) * (next_base_row[31usize]))))))
                        * ((challenges[7usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_272)
                                    + ((challenges[18usize])
                                        * ((next_base_row[38usize])
                                            + (BFieldElement::from_raw_u64(30064771065u64)))))
                                    + ((challenges[19usize]) * (next_base_row[30usize]))))))),
            (current_ext_row[66usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_ext_row[60usize])
                        * ((challenges[7usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_272)
                                    + ((challenges[18usize])
                                        * ((current_base_row[38usize])
                                            + (BFieldElement::from_raw_u64(21474836475u64)))))
                                    + ((challenges[19usize]) * (current_base_row[32usize]))))))
                        * ((challenges[7usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_272)
                                    + ((challenges[18usize])
                                        * ((current_base_row[38usize])
                                            + (BFieldElement::from_raw_u64(25769803770u64)))))
                                    + ((challenges[19usize]) * (current_base_row[31usize]))))))
                        * ((challenges[7usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_272)
                                    + ((challenges[18usize])
                                        * ((current_base_row[38usize])
                                            + (BFieldElement::from_raw_u64(30064771065u64)))))
                                    + ((challenges[19usize])
                                        * (current_base_row[30usize]))))))),
            (current_ext_row[67usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_ext_row[6usize])
                        * (((current_ext_row[65usize])
                            * ((challenges[7usize])
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (((node_272)
                                        + ((challenges[18usize])
                                            * ((next_base_row[38usize])
                                                + (BFieldElement::from_raw_u64(34359738360u64)))))
                                        + ((challenges[19usize]) * (next_base_row[29usize]))))))
                            * ((challenges[7usize])
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (((node_272)
                                        + ((challenges[18usize])
                                            * ((next_base_row[38usize])
                                                + (BFieldElement::from_raw_u64(38654705655u64)))))
                                        + ((challenges[19usize]) * (next_base_row[28usize])))))))),
            (current_ext_row[68usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_ext_row[6usize])
                        * (((current_ext_row[66usize])
                            * ((challenges[7usize])
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (((node_272)
                                        + ((challenges[18usize])
                                            * ((current_base_row[38usize])
                                                + (BFieldElement::from_raw_u64(34359738360u64)))))
                                        + ((challenges[19usize]) * (current_base_row[29usize]))))))
                            * ((challenges[7usize])
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (((node_272)
                                        + ((challenges[18usize])
                                            * ((current_base_row[38usize])
                                                + (BFieldElement::from_raw_u64(38654705655u64)))))
                                        + ((challenges[19usize])
                                            * (current_base_row[28usize])))))))),
            (current_ext_row[69usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[199usize])
                        * ((next_ext_row[7usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * ((current_ext_row[7usize])
                                    * ((current_ext_row[63usize])
                                        * ((challenges[8usize])
                                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                                * (((node_1274)
                                                    + (((next_base_row[22usize])
                                                        + (BFieldElement::from_raw_u64(21474836475u64)))
                                                        * (challenges[21usize])))
                                                    + ((next_base_row[27usize])
                                                        * (challenges[22usize]))))))))))),
            (current_ext_row[70usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[199usize])
                        * ((next_ext_row[7usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * ((current_ext_row[7usize])
                                    * ((current_ext_row[64usize])
                                        * ((challenges[8usize])
                                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                                * (((node_1272)
                                                    + (((current_base_row[22usize])
                                                        + (BFieldElement::from_raw_u64(17179869180u64)))
                                                        * (challenges[21usize])))
                                                    + ((current_base_row[27usize])
                                                        * (challenges[22usize]))))))))))),
            (current_ext_row[71usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((((challenges[8usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((node_1274)
                                + ((current_base_row[29usize]) * (challenges[21usize])))
                                + (node_2153))))
                        * ((challenges[8usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_1274)
                                    + (((current_base_row[29usize])
                                        + (BFieldElement::from_raw_u64(4294967295u64)))
                                        * (challenges[21usize]))) + (node_2159)))))
                        * ((challenges[8usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_1274)
                                    + (((current_base_row[29usize])
                                        + (BFieldElement::from_raw_u64(8589934590u64)))
                                        * (challenges[21usize]))) + (node_2166)))))
                        * ((challenges[8usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_1274)
                                    + (((current_base_row[29usize])
                                        + (BFieldElement::from_raw_u64(12884901885u64)))
                                        * (challenges[21usize]))) + (node_2173)))))),
            (current_ext_row[72usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((node_2216)
                        * ((challenges[8usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_1274) + (node_1533)) + (node_2159)))))
                        * ((challenges[8usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_1274) + (node_1573)) + (node_2166)))))
                        * ((challenges[8usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * ((node_2228) + (node_2173)))))),
            (current_ext_row[73usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((node_2216)
                        * ((challenges[8usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * ((node_2228) + (node_2159)))))
                        * ((challenges[8usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * ((node_2234) + (node_2166)))))
                        * ((challenges[8usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * ((node_2240) + (node_2173)))))),
            (current_ext_row[74usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[195usize]) * (node_286))),
            (current_ext_row[75usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[196usize])
                        * ((next_ext_row[6usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * ((current_ext_row[6usize])
                                    * (current_ext_row[50usize])))))),
            (current_ext_row[76usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[197usize]) * (node_385))),
            (current_ext_row[77usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[198usize])
                        * ((next_ext_row[6usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * ((current_ext_row[6usize])
                                    * (current_ext_row[54usize])))))),
            (current_ext_row[78usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[195usize]) * (node_567))),
            (current_ext_row[79usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[196usize])
                        * ((next_ext_row[6usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * ((current_ext_row[6usize])
                                    * (current_ext_row[51usize])))))),
            (current_ext_row[80usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[197usize])
                        * ((next_ext_row[6usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * ((current_ext_row[6usize])
                                    * (current_ext_row[53usize])))))),
            (current_ext_row[81usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[198usize])
                        * ((next_ext_row[6usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * ((current_ext_row[6usize])
                                    * (current_ext_row[55usize])))))),
            (current_ext_row[82usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[199usize])
                        * ((next_ext_row[6usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * ((current_ext_row[6usize])
                                    * (current_ext_row[60usize])))))),
            (current_ext_row[83usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_ext_row[7usize])
                        * (((current_ext_row[72usize])
                            * ((challenges[8usize])
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * ((node_2234) + (node_2180)))))
                            * ((challenges[8usize])
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * ((node_2240)
                                        + ((current_base_row[44usize])
                                            * (challenges[22usize])))))))),
            (current_ext_row[84usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((node_4488)
                        * ((challenges[11usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * ((next_base_row[50usize])
                                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                        * (current_base_row[50usize]))))))
                        + (BFieldElement::from_raw_u64(18446744065119617026u64)))
                        * (node_4413))),
            (current_ext_row[85usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[297usize])
                        * (((current_ext_row[7usize])
                            * ((current_ext_row[71usize])
                                * ((challenges[8usize])
                                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                        * (((node_1274)
                                            + (((current_base_row[29usize])
                                                + (BFieldElement::from_raw_u64(17179869180u64)))
                                                * (challenges[21usize]))) + (node_2180))))))
                            + (node_2186)))),
            (current_ext_row[86usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[218usize])
                        * ((((((current_base_row[195usize])
                            * ((next_ext_row[7usize])
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * ((current_ext_row[7usize]) * (node_1283)))))
                            + ((current_base_row[196usize])
                                * ((next_ext_row[7usize])
                                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                        * ((current_ext_row[7usize])
                                            * (current_ext_row[57usize]))))))
                            + ((current_base_row[197usize])
                                * ((next_ext_row[7usize])
                                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                        * ((current_ext_row[7usize])
                                            * (current_ext_row[61usize]))))))
                            + ((current_base_row[198usize])
                                * ((next_ext_row[7usize])
                                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                        * ((current_ext_row[7usize])
                                            * (current_ext_row[63usize]))))))
                            + (current_ext_row[69usize])))),
            (current_ext_row[87usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[224usize])
                        * ((((((current_base_row[195usize])
                            * ((next_ext_row[7usize])
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * ((current_ext_row[7usize]) * (node_1511)))))
                            + ((current_base_row[196usize])
                                * ((next_ext_row[7usize])
                                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                        * ((current_ext_row[7usize])
                                            * (current_ext_row[58usize]))))))
                            + ((current_base_row[197usize])
                                * ((next_ext_row[7usize])
                                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                        * ((current_ext_row[7usize])
                                            * (current_ext_row[62usize]))))))
                            + ((current_base_row[198usize])
                                * ((next_ext_row[7usize])
                                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                        * ((current_ext_row[7usize])
                                            * (current_ext_row[64usize]))))))
                            + (current_ext_row[70usize])))),
        ];
        base_constraints
            .into_iter()
            .map(|bfe| bfe.lift())
            .chain(ext_constraints)
            .collect()
    }
    #[allow(unused_variables)]
    fn evaluate_terminal_constraints(
        base_row: ArrayView1<BFieldElement>,
        ext_row: ArrayView1<XFieldElement>,
        challenges: &Challenges,
    ) -> Vec<XFieldElement> {
        let base_constraints = [
            (base_row[5usize]) + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((base_row[3usize]) + (BFieldElement::from_raw_u64(18446744030759878666u64)))
                * ((base_row[6usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))),
            base_row[10usize],
            ((base_row[62usize])
                * ((base_row[63usize])
                    + (BFieldElement::from_raw_u64(18446743897615892521u64))))
                * ((base_row[64usize])
                    + (BFieldElement::from_raw_u64(18446744047939747846u64))),
            (base_row[143usize])
                * ((base_row[142usize])
                    + (BFieldElement::from_raw_u64(18446743940565565471u64))),
            base_row[145usize],
        ];
        let ext_constraints = [
            (((ext_row[18usize]) * (ext_row[16usize]))
                + ((ext_row[19usize]) * (ext_row[17usize])))
                + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((((base_row[62usize])
                + (BFieldElement::from_raw_u64(18446744060824649731u64)))
                * ((base_row[62usize])
                    + (BFieldElement::from_raw_u64(18446744056529682436u64))))
                * (base_row[62usize]))
                * (((((((((((challenges[0usize])
                    + ((((((base_row[65usize])
                        * (BFieldElement::from_raw_u64(18446744069414518785u64)))
                        + ((base_row[66usize])
                            * (BFieldElement::from_raw_u64(18446744069414584320u64))))
                        + ((base_row[67usize])
                            * (BFieldElement::from_raw_u64(281474976645120u64))))
                        + (base_row[68usize])) * (BFieldElement::from_raw_u64(1u64))))
                    * (challenges[0usize]))
                    + ((((((base_row[69usize])
                        * (BFieldElement::from_raw_u64(18446744069414518785u64)))
                        + ((base_row[70usize])
                            * (BFieldElement::from_raw_u64(18446744069414584320u64))))
                        + ((base_row[71usize])
                            * (BFieldElement::from_raw_u64(281474976645120u64))))
                        + (base_row[72usize])) * (BFieldElement::from_raw_u64(1u64))))
                    * (challenges[0usize]))
                    + ((((((base_row[73usize])
                        * (BFieldElement::from_raw_u64(18446744069414518785u64)))
                        + ((base_row[74usize])
                            * (BFieldElement::from_raw_u64(18446744069414584320u64))))
                        + ((base_row[75usize])
                            * (BFieldElement::from_raw_u64(281474976645120u64))))
                        + (base_row[76usize])) * (BFieldElement::from_raw_u64(1u64))))
                    * (challenges[0usize]))
                    + ((((((base_row[77usize])
                        * (BFieldElement::from_raw_u64(18446744069414518785u64)))
                        + ((base_row[78usize])
                            * (BFieldElement::from_raw_u64(18446744069414584320u64))))
                        + ((base_row[79usize])
                            * (BFieldElement::from_raw_u64(281474976645120u64))))
                        + (base_row[80usize])) * (BFieldElement::from_raw_u64(1u64))))
                    * (challenges[0usize])) + (base_row[97usize]))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (challenges[62usize]))),
            (ext_row[47usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (challenges[61usize])),
            (ext_row[2usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[24usize])),
            (challenges[59usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[3usize])),
            (ext_row[4usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (challenges[60usize])),
            (ext_row[5usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[0usize])),
            (ext_row[6usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[14usize])),
            (ext_row[7usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[20usize])),
            (ext_row[8usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[22usize])),
            (ext_row[9usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[25usize])),
            (ext_row[26usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[10usize])),
            (ext_row[11usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[27usize])),
            ((((((((((((((((ext_row[44usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[28usize])))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[29usize])))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[30usize])))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[31usize])))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[32usize])))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[33usize])))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[34usize])))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[35usize])))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[36usize])))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[37usize])))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[38usize])))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[39usize])))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[40usize])))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[41usize])))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[42usize])))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[43usize])),
            (ext_row[45usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[46usize])),
            (ext_row[12usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[48usize])),
            (((ext_row[13usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[15usize])))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[21usize])))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[23usize])),
        ];
        base_constraints
            .into_iter()
            .map(|bfe| bfe.lift())
            .chain(ext_constraints)
            .collect()
    }
}
impl Evaluable<XFieldElement> for MasterExtTable {
    #[allow(unused_variables)]
    fn evaluate_initial_constraints(
        base_row: ArrayView1<XFieldElement>,
        ext_row: ArrayView1<XFieldElement>,
        challenges: &Challenges,
    ) -> Vec<XFieldElement> {
        let node_468 = (BFieldElement::from_raw_u64(4294967295u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (base_row[129usize]));
        let node_474 = ((challenges[52usize]) * (base_row[131usize]))
            + ((challenges[53usize]) * (base_row[133usize]));
        let node_477 = ((challenges[52usize]) * (base_row[130usize]))
            + ((challenges[53usize]) * (base_row[132usize]));
        let base_constraints = [
            base_row[0usize],
            base_row[3usize],
            base_row[5usize],
            base_row[7usize],
            base_row[9usize],
            base_row[19usize],
            base_row[20usize],
            base_row[21usize],
            base_row[22usize],
            base_row[23usize],
            base_row[24usize],
            base_row[25usize],
            base_row[26usize],
            base_row[27usize],
            base_row[28usize],
            base_row[29usize],
            base_row[30usize],
            base_row[31usize],
            base_row[32usize],
            (base_row[38usize]) + (BFieldElement::from_raw_u64(18446744000695107601u64)),
            (base_row[48usize]) + (BFieldElement::from_raw_u64(18446744000695107601u64)),
            base_row[55usize],
            base_row[57usize],
            base_row[59usize],
            base_row[60usize],
            base_row[61usize],
            (base_row[62usize]) + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            base_row[64usize],
            base_row[136usize],
            (base_row[149usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((((base_row[12usize])
                        + (BFieldElement::from_raw_u64(18446744065119617026u64)))
                        * (base_row[13usize]))
                        * ((base_row[14usize])
                            + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                        * ((base_row[15usize])
                            + (BFieldElement::from_raw_u64(18446744065119617026u64))))),
            (base_row[150usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((base_row[149usize]) * (base_row[16usize]))
                        * ((base_row[17usize])
                            + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                        * ((base_row[18usize])
                            + (BFieldElement::from_raw_u64(18446744065119617026u64))))),
        ];
        let ext_constraints = [
            ext_row[0usize],
            ((ext_row[1usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (challenges[29usize])))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (base_row[1usize])),
            (ext_row[2usize]) + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((((((((((challenges[0usize]) + (base_row[33usize])) * (challenges[0usize]))
                + (base_row[34usize])) * (challenges[0usize])) + (base_row[35usize]))
                * (challenges[0usize])) + (base_row[36usize])) * (challenges[0usize]))
                + (base_row[37usize]))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (challenges[62usize])),
            (ext_row[3usize]) + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((ext_row[5usize])
                * ((challenges[3usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (((challenges[14usize]) * (base_row[10usize]))
                            + ((challenges[15usize]) * (base_row[11usize]))))))
                + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            (ext_row[4usize]) + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            (ext_row[6usize]) + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            (ext_row[7usize]) + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            (ext_row[8usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((challenges[9usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * ((challenges[25usize]) * (base_row[10usize]))))),
            ((ext_row[13usize]) * (challenges[11usize]))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (base_row[45usize])),
            (((base_row[10usize])
                + (BFieldElement::from_raw_u64(18446743992105173011u64)))
                * ((ext_row[9usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                + ((base_row[150usize])
                    * ((ext_row[9usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (challenges[4usize])))),
            (ext_row[10usize]) + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            (ext_row[11usize]) + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ext_row[12usize],
            (((ext_row[14usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((challenges[7usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((((challenges[16usize]) * (base_row[46usize]))
                                + ((challenges[17usize]) * (base_row[47usize])))
                                + ((challenges[18usize])
                                    * (BFieldElement::from_raw_u64(68719476720u64))))
                                + ((challenges[19usize]) * (base_row[49usize])))))))
                * ((base_row[47usize])
                    + (BFieldElement::from_raw_u64(18446744060824649731u64))))
                + (((ext_row[14usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64)))
                    * ((base_row[47usize])
                        * ((base_row[47usize])
                            + (BFieldElement::from_raw_u64(18446744065119617026u64))))),
            ext_row[15usize],
            ext_row[18usize],
            (ext_row[19usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (base_row[56usize])),
            ((ext_row[16usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (challenges[12usize]))) + (base_row[52usize]),
            (ext_row[17usize]) + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((((ext_row[20usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (challenges[8usize])))
                + (((((base_row[50usize]) * (challenges[20usize]))
                    + ((base_row[51usize]) * (challenges[23usize])))
                    + ((base_row[52usize]) * (challenges[21usize])))
                    + ((base_row[53usize]) * (challenges[22usize]))))
                * ((base_row[51usize])
                    + (BFieldElement::from_raw_u64(18446744060824649731u64))))
                + (((ext_row[20usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64)))
                    * (((base_row[51usize])
                        + (BFieldElement::from_raw_u64(18446744065119617026u64)))
                        * (base_row[51usize]))),
            ext_row[21usize],
            (ext_row[22usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((challenges[9usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * ((challenges[25usize]) * (base_row[58usize]))))),
            ext_row[23usize],
            (ext_row[25usize]) + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            (ext_row[26usize]) + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            (ext_row[27usize]) + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((ext_row[24usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (challenges[30usize])))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((((((((((((((((((challenges[29usize])
                        + ((((((base_row[65usize])
                            * (BFieldElement::from_raw_u64(18446744069414518785u64)))
                            + ((base_row[66usize])
                                * (BFieldElement::from_raw_u64(18446744069414584320u64))))
                            + ((base_row[67usize])
                                * (BFieldElement::from_raw_u64(281474976645120u64))))
                            + (base_row[68usize]))
                            * (BFieldElement::from_raw_u64(1u64))))
                        * (challenges[29usize]))
                        + ((((((base_row[69usize])
                            * (BFieldElement::from_raw_u64(18446744069414518785u64)))
                            + ((base_row[70usize])
                                * (BFieldElement::from_raw_u64(18446744069414584320u64))))
                            + ((base_row[71usize])
                                * (BFieldElement::from_raw_u64(281474976645120u64))))
                            + (base_row[72usize]))
                            * (BFieldElement::from_raw_u64(1u64))))
                        * (challenges[29usize]))
                        + ((((((base_row[73usize])
                            * (BFieldElement::from_raw_u64(18446744069414518785u64)))
                            + ((base_row[74usize])
                                * (BFieldElement::from_raw_u64(18446744069414584320u64))))
                            + ((base_row[75usize])
                                * (BFieldElement::from_raw_u64(281474976645120u64))))
                            + (base_row[76usize]))
                            * (BFieldElement::from_raw_u64(1u64))))
                        * (challenges[29usize]))
                        + ((((((base_row[77usize])
                            * (BFieldElement::from_raw_u64(18446744069414518785u64)))
                            + ((base_row[78usize])
                                * (BFieldElement::from_raw_u64(18446744069414584320u64))))
                            + ((base_row[79usize])
                                * (BFieldElement::from_raw_u64(281474976645120u64))))
                            + (base_row[80usize]))
                            * (BFieldElement::from_raw_u64(1u64))))
                        * (challenges[29usize])) + (base_row[97usize]))
                        * (challenges[29usize])) + (base_row[98usize]))
                        * (challenges[29usize])) + (base_row[99usize]))
                        * (challenges[29usize])) + (base_row[100usize]))
                        * (challenges[29usize])) + (base_row[101usize]))
                        * (challenges[29usize])) + (base_row[102usize]))),
            ((ext_row[28usize])
                * ((challenges[48usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (((challenges[49usize]) * (base_row[65usize]))
                            + ((challenges[50usize]) * (base_row[81usize]))))))
                + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((ext_row[29usize])
                * ((challenges[48usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (((challenges[49usize]) * (base_row[66usize]))
                            + ((challenges[50usize]) * (base_row[82usize]))))))
                + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((ext_row[30usize])
                * ((challenges[48usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (((challenges[49usize]) * (base_row[67usize]))
                            + ((challenges[50usize]) * (base_row[83usize]))))))
                + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((ext_row[31usize])
                * ((challenges[48usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (((challenges[49usize]) * (base_row[68usize]))
                            + ((challenges[50usize]) * (base_row[84usize]))))))
                + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((ext_row[32usize])
                * ((challenges[48usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (((challenges[49usize]) * (base_row[69usize]))
                            + ((challenges[50usize]) * (base_row[85usize]))))))
                + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((ext_row[33usize])
                * ((challenges[48usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (((challenges[49usize]) * (base_row[70usize]))
                            + ((challenges[50usize]) * (base_row[86usize]))))))
                + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((ext_row[34usize])
                * ((challenges[48usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (((challenges[49usize]) * (base_row[71usize]))
                            + ((challenges[50usize]) * (base_row[87usize]))))))
                + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((ext_row[35usize])
                * ((challenges[48usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (((challenges[49usize]) * (base_row[72usize]))
                            + ((challenges[50usize]) * (base_row[88usize]))))))
                + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((ext_row[36usize])
                * ((challenges[48usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (((challenges[49usize]) * (base_row[73usize]))
                            + ((challenges[50usize]) * (base_row[89usize]))))))
                + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((ext_row[37usize])
                * ((challenges[48usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (((challenges[49usize]) * (base_row[74usize]))
                            + ((challenges[50usize]) * (base_row[90usize]))))))
                + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((ext_row[38usize])
                * ((challenges[48usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (((challenges[49usize]) * (base_row[75usize]))
                            + ((challenges[50usize]) * (base_row[91usize]))))))
                + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((ext_row[39usize])
                * ((challenges[48usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (((challenges[49usize]) * (base_row[76usize]))
                            + ((challenges[50usize]) * (base_row[92usize]))))))
                + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((ext_row[40usize])
                * ((challenges[48usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (((challenges[49usize]) * (base_row[77usize]))
                            + ((challenges[50usize]) * (base_row[93usize]))))))
                + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((ext_row[41usize])
                * ((challenges[48usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (((challenges[49usize]) * (base_row[78usize]))
                            + ((challenges[50usize]) * (base_row[94usize]))))))
                + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((ext_row[42usize])
                * ((challenges[48usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (((challenges[49usize]) * (base_row[79usize]))
                            + ((challenges[50usize]) * (base_row[95usize]))))))
                + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((ext_row[43usize])
                * ((challenges[48usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (((challenges[49usize]) * (base_row[80usize]))
                            + ((challenges[50usize]) * (base_row[96usize]))))))
                + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((node_468)
                * (((ext_row[44usize])
                    * ((challenges[48usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((challenges[49usize])
                                * (((BFieldElement::from_raw_u64(1099511627520u64))
                                    * (base_row[130usize])) + (base_row[131usize])))
                                + ((challenges[50usize])
                                    * (((BFieldElement::from_raw_u64(1099511627520u64))
                                        * (base_row[132usize])) + (base_row[133usize])))))))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (base_row[134usize]))))
                + ((base_row[129usize]) * (ext_row[44usize])),
            ((node_468)
                * ((((((ext_row[45usize])
                    * ((challenges[51usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (node_474))))
                    * ((challenges[51usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (node_477))))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((BFieldElement::from_raw_u64(8589934590u64))
                            * (challenges[51usize])))) + (node_474)) + (node_477)))
                + ((base_row[129usize]) * (ext_row[45usize])),
            ((ext_row[46usize])
                * ((challenges[51usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((base_row[137usize]) * (challenges[53usize])))))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (base_row[138usize])),
            ((ext_row[47usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (challenges[54usize])))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (base_row[137usize])),
            (((base_row[139usize])
                + (BFieldElement::from_raw_u64(18446744065119617026u64)))
                * (ext_row[48usize]))
                + ((base_row[139usize])
                    * (((ext_row[48usize])
                        * ((challenges[10usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((((challenges[55usize]) * (base_row[143usize]))
                                    + ((challenges[56usize]) * (base_row[145usize])))
                                    + ((challenges[57usize]) * (base_row[142usize])))
                                    + ((challenges[58usize]) * (base_row[147usize]))))))
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (base_row[148usize])))),
        ];
        base_constraints.into_iter().chain(ext_constraints).collect()
    }
    #[allow(unused_variables)]
    fn evaluate_consistency_constraints(
        base_row: ArrayView1<XFieldElement>,
        ext_row: ArrayView1<XFieldElement>,
        challenges: &Challenges,
    ) -> Vec<XFieldElement> {
        let node_102 = (base_row[152usize])
            * ((base_row[64usize])
                + (BFieldElement::from_raw_u64(18446744047939747846u64)));
        let node_221 = (base_row[153usize])
            * ((base_row[64usize])
                + (BFieldElement::from_raw_u64(18446744047939747846u64)));
        let node_238 = ((base_row[154usize])
            * ((base_row[64usize])
                + (BFieldElement::from_raw_u64(18446744052234715141u64))))
            * ((base_row[64usize])
                + (BFieldElement::from_raw_u64(18446744047939747846u64)));
        let node_245 = ((base_row[154usize])
            * ((base_row[64usize])
                + (BFieldElement::from_raw_u64(18446744056529682436u64))))
            * ((base_row[64usize])
                + (BFieldElement::from_raw_u64(18446744047939747846u64)));
        let node_655 = (BFieldElement::from_raw_u64(4294967295u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (base_row[157usize]));
        let node_114 = (((base_row[63usize])
            + (BFieldElement::from_raw_u64(18446743992105173011u64)))
            * ((base_row[63usize])
                + (BFieldElement::from_raw_u64(18446743923385696291u64))))
            * ((base_row[63usize])
                + (BFieldElement::from_raw_u64(18446743828896415801u64)));
        let node_116 = (node_102) * (base_row[161usize]);
        let node_660 = (BFieldElement::from_raw_u64(4294967295u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (base_row[160usize]));
        let node_101 = (base_row[64usize])
            + (BFieldElement::from_raw_u64(18446744047939747846u64));
        let node_678 = (base_row[142usize])
            + (BFieldElement::from_raw_u64(18446743949155500061u64));
        let node_674 = (base_row[142usize])
            + (BFieldElement::from_raw_u64(18446743940565565471u64));
        let node_94 = (base_row[64usize])
            + (BFieldElement::from_raw_u64(18446744056529682436u64));
        let node_97 = (base_row[64usize])
            + (BFieldElement::from_raw_u64(18446744052234715141u64));
        let node_153 = ((((BFieldElement::from_raw_u64(18446744065119617025u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((base_row[65usize])
                    * (BFieldElement::from_raw_u64(281474976645120u64)))))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (base_row[66usize]))) * (base_row[109usize]))
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_155 = ((((BFieldElement::from_raw_u64(18446744065119617025u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((base_row[69usize])
                    * (BFieldElement::from_raw_u64(281474976645120u64)))))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (base_row[70usize]))) * (base_row[110usize]))
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_157 = ((((BFieldElement::from_raw_u64(18446744065119617025u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((base_row[73usize])
                    * (BFieldElement::from_raw_u64(281474976645120u64)))))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (base_row[74usize]))) * (base_row[111usize]))
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_159 = ((((BFieldElement::from_raw_u64(18446744065119617025u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((base_row[77usize])
                    * (BFieldElement::from_raw_u64(281474976645120u64)))))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (base_row[78usize]))) * (base_row[112usize]))
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_680 = (base_row[139usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_90 = (base_row[64usize])
            + (BFieldElement::from_raw_u64(18446744060824649731u64));
        let node_670 = (base_row[142usize])
            + (BFieldElement::from_raw_u64(18446744017874976781u64));
        let node_11 = (BFieldElement::from_raw_u64(4294967295u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (((BFieldElement::from_raw_u64(38654705655u64))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (base_row[3usize]))) * (base_row[4usize])));
        let node_8 = (BFieldElement::from_raw_u64(38654705655u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (base_row[3usize]));
        let node_104 = (((base_row[62usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64)))
            * ((base_row[62usize])
                + (BFieldElement::from_raw_u64(18446744060824649731u64))))
            * ((base_row[62usize])
                + (BFieldElement::from_raw_u64(18446744056529682436u64)));
        let node_85 = (base_row[62usize])
            + (BFieldElement::from_raw_u64(18446744060824649731u64));
        let node_73 = (base_row[63usize])
            + (BFieldElement::from_raw_u64(18446743992105173011u64));
        let node_79 = (base_row[63usize])
            + (BFieldElement::from_raw_u64(18446743923385696291u64));
        let node_82 = (base_row[63usize])
            + (BFieldElement::from_raw_u64(18446743828896415801u64));
        let node_126 = ((BFieldElement::from_raw_u64(18446744065119617025u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((base_row[65usize])
                    * (BFieldElement::from_raw_u64(281474976645120u64)))))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (base_row[66usize]));
        let node_133 = ((BFieldElement::from_raw_u64(18446744065119617025u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((base_row[69usize])
                    * (BFieldElement::from_raw_u64(281474976645120u64)))))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (base_row[70usize]));
        let node_140 = ((BFieldElement::from_raw_u64(18446744065119617025u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((base_row[73usize])
                    * (BFieldElement::from_raw_u64(281474976645120u64)))))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (base_row[74usize]));
        let node_147 = ((BFieldElement::from_raw_u64(18446744065119617025u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((base_row[77usize])
                    * (BFieldElement::from_raw_u64(281474976645120u64)))))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (base_row[78usize]));
        let node_89 = (base_row[64usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_663 = (base_row[142usize])
            + (BFieldElement::from_raw_u64(18446744052234715141u64));
        let node_666 = (base_row[142usize])
            + (BFieldElement::from_raw_u64(18446744009285042191u64));
        let node_86 = ((base_row[62usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64))) * (node_85);
        let node_83 = (base_row[62usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_103 = (base_row[62usize])
            + (BFieldElement::from_raw_u64(18446744056529682436u64));
        let base_constraints = [
            (node_11) * (base_row[4usize]),
            (node_11) * (node_8),
            (base_row[5usize])
                * ((base_row[5usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))),
            (base_row[6usize])
                * ((base_row[6usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))),
            (base_row[12usize])
                * ((base_row[12usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))),
            (base_row[13usize])
                * ((base_row[13usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))),
            (base_row[14usize])
                * ((base_row[14usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))),
            (base_row[15usize])
                * ((base_row[15usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))),
            (base_row[16usize])
                * ((base_row[16usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))),
            (base_row[17usize])
                * ((base_row[17usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))),
            (base_row[18usize])
                * ((base_row[18usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))),
            (base_row[8usize])
                * ((base_row[8usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))),
            (base_row[10usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((((((base_row[12usize])
                        + ((BFieldElement::from_raw_u64(8589934590u64))
                            * (base_row[13usize])))
                        + ((BFieldElement::from_raw_u64(17179869180u64))
                            * (base_row[14usize])))
                        + ((BFieldElement::from_raw_u64(34359738360u64))
                            * (base_row[15usize])))
                        + ((BFieldElement::from_raw_u64(68719476720u64))
                            * (base_row[16usize])))
                        + ((BFieldElement::from_raw_u64(137438953440u64))
                            * (base_row[17usize])))
                        + ((BFieldElement::from_raw_u64(274877906880u64))
                            * (base_row[18usize])))),
            ((base_row[8usize])
                * ((base_row[7usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                * (base_row[45usize]),
            (node_104) * (base_row[62usize]),
            (node_85) * (node_73),
            ((base_row[165usize]) * (node_79)) * (node_82),
            (node_104) * (base_row[64usize]),
            (node_114) * (base_row[64usize]),
            (node_153) * (base_row[109usize]),
            (node_155) * (base_row[110usize]),
            (node_157) * (base_row[111usize]),
            (node_159) * (base_row[112usize]),
            (node_153) * (node_126),
            (node_155) * (node_133),
            (node_157) * (node_140),
            (node_159) * (node_147),
            (node_153)
                * (((base_row[67usize])
                    * (BFieldElement::from_raw_u64(281474976645120u64)))
                    + (base_row[68usize])),
            (node_155)
                * (((base_row[71usize])
                    * (BFieldElement::from_raw_u64(281474976645120u64)))
                    + (base_row[72usize])),
            (node_157)
                * (((base_row[75usize])
                    * (BFieldElement::from_raw_u64(281474976645120u64)))
                    + (base_row[76usize])),
            (node_159)
                * (((base_row[79usize])
                    * (BFieldElement::from_raw_u64(281474976645120u64)))
                    + (base_row[80usize])),
            (node_114) * (base_row[103usize]),
            (node_114) * (base_row[104usize]),
            (node_114) * (base_row[105usize]),
            (node_114) * (base_row[106usize]),
            (node_114) * (base_row[107usize]),
            (node_114) * (base_row[108usize]),
            (node_116)
                * ((base_row[103usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))),
            (node_116)
                * ((base_row[104usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))),
            (node_116)
                * ((base_row[105usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))),
            (node_116)
                * ((base_row[106usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))),
            (node_116)
                * ((base_row[107usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))),
            (node_116)
                * ((base_row[108usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))),
            (((((node_102)
                * ((base_row[113usize])
                    + (BFieldElement::from_raw_u64(11408918724931329738u64))))
                + ((node_221)
                    * ((base_row[113usize])
                        + (BFieldElement::from_raw_u64(16073625066478178581u64)))))
                + ((base_row[155usize])
                    * ((base_row[113usize])
                        + (BFieldElement::from_raw_u64(12231462398569191607u64)))))
                + ((node_238)
                    * ((base_row[113usize])
                        + (BFieldElement::from_raw_u64(9408518518620565480u64)))))
                + ((node_245)
                    * ((base_row[113usize])
                        + (BFieldElement::from_raw_u64(11492978409391175103u64)))),
            (((((node_102)
                * ((base_row[114usize])
                    + (BFieldElement::from_raw_u64(2786462832312611053u64))))
                + ((node_221)
                    * ((base_row[114usize])
                        + (BFieldElement::from_raw_u64(11837051899140380443u64)))))
                + ((base_row[155usize])
                    * ((base_row[114usize])
                        + (BFieldElement::from_raw_u64(11546487907579866869u64)))))
                + ((node_238)
                    * ((base_row[114usize])
                        + (BFieldElement::from_raw_u64(1785884128667671832u64)))))
                + ((node_245)
                    * ((base_row[114usize])
                        + (BFieldElement::from_raw_u64(17615222217495663839u64)))),
            (((((node_102)
                * ((base_row[115usize])
                    + (BFieldElement::from_raw_u64(6782977121958050999u64))))
                + ((node_221)
                    * ((base_row[115usize])
                        + (BFieldElement::from_raw_u64(15625104599191418968u64)))))
                + ((base_row[155usize])
                    * ((base_row[115usize])
                        + (BFieldElement::from_raw_u64(14006427992450931468u64)))))
                + ((node_238)
                    * ((base_row[115usize])
                        + (BFieldElement::from_raw_u64(1188899344229954938u64)))))
                + ((node_245)
                    * ((base_row[115usize])
                        + (BFieldElement::from_raw_u64(5864349944556149748u64)))),
            (((((node_102)
                * ((base_row[116usize])
                    + (BFieldElement::from_raw_u64(8688421733879975670u64))))
                + ((node_221)
                    * ((base_row[116usize])
                        + (BFieldElement::from_raw_u64(12819157612210448391u64)))))
                + ((base_row[155usize])
                    * ((base_row[116usize])
                        + (BFieldElement::from_raw_u64(11770003398407723041u64)))))
                + ((node_238)
                    * ((base_row[116usize])
                        + (BFieldElement::from_raw_u64(14740727267735052728u64)))))
                + ((node_245)
                    * ((base_row[116usize])
                        + (BFieldElement::from_raw_u64(2745609811140253793u64)))),
            (((((node_102)
                * ((base_row[117usize])
                    + (BFieldElement::from_raw_u64(8602724563769480463u64))))
                + ((node_221)
                    * ((base_row[117usize])
                        + (BFieldElement::from_raw_u64(6235256903503367222u64)))))
                + ((base_row[155usize])
                    * ((base_row[117usize])
                        + (BFieldElement::from_raw_u64(15124190001489436038u64)))))
                + ((node_238)
                    * ((base_row[117usize])
                        + (BFieldElement::from_raw_u64(880257844992994007u64)))))
                + ((node_245)
                    * ((base_row[117usize])
                        + (BFieldElement::from_raw_u64(15189664869386394185u64)))),
            (((((node_102)
                * ((base_row[118usize])
                    + (BFieldElement::from_raw_u64(13589155570211330507u64))))
                + ((node_221)
                    * ((base_row[118usize])
                        + (BFieldElement::from_raw_u64(11242082964257948320u64)))))
                + ((base_row[155usize])
                    * ((base_row[118usize])
                        + (BFieldElement::from_raw_u64(14834674155811570980u64)))))
                + ((node_238)
                    * ((base_row[118usize])
                        + (BFieldElement::from_raw_u64(10737952517017171197u64)))))
                + ((node_245)
                    * ((base_row[118usize])
                        + (BFieldElement::from_raw_u64(5192963426821415349u64)))),
            (((((node_102)
                * ((base_row[119usize])
                    + (BFieldElement::from_raw_u64(10263462378312899510u64))))
                + ((node_221)
                    * ((base_row[119usize])
                        + (BFieldElement::from_raw_u64(5820425254787221108u64)))))
                + ((base_row[155usize])
                    * ((base_row[119usize])
                        + (BFieldElement::from_raw_u64(13004675752386552573u64)))))
                + ((node_238)
                    * ((base_row[119usize])
                        + (BFieldElement::from_raw_u64(15757222735741919824u64)))))
                + ((node_245)
                    * ((base_row[119usize])
                        + (BFieldElement::from_raw_u64(11971160388083607515u64)))),
            (((((node_102)
                * ((base_row[120usize])
                    + (BFieldElement::from_raw_u64(3264875873073042616u64))))
                + ((node_221)
                    * ((base_row[120usize])
                        + (BFieldElement::from_raw_u64(12019227591549292608u64)))))
                + ((base_row[155usize])
                    * ((base_row[120usize])
                        + (BFieldElement::from_raw_u64(1475232519215872482u64)))))
                + ((node_238)
                    * ((base_row[120usize])
                        + (BFieldElement::from_raw_u64(14382578632612566479u64)))))
                + ((node_245)
                    * ((base_row[120usize])
                        + (BFieldElement::from_raw_u64(11608544217838050708u64)))),
            (((((node_102)
                * ((base_row[121usize])
                    + (BFieldElement::from_raw_u64(3133435276616064683u64))))
                + ((node_221)
                    * ((base_row[121usize])
                        + (BFieldElement::from_raw_u64(4625353063880731092u64)))))
                + ((base_row[155usize])
                    * ((base_row[121usize])
                        + (BFieldElement::from_raw_u64(4883869161905122316u64)))))
                + ((node_238)
                    * ((base_row[121usize])
                        + (BFieldElement::from_raw_u64(3305272539067787726u64)))))
                + ((node_245)
                    * ((base_row[121usize])
                        + (BFieldElement::from_raw_u64(674972795234232729u64)))),
            (((((node_102)
                * ((base_row[122usize])
                    + (BFieldElement::from_raw_u64(13508500531157332153u64))))
                + ((node_221)
                    * ((base_row[122usize])
                        + (BFieldElement::from_raw_u64(3723900760706330287u64)))))
                + ((base_row[155usize])
                    * ((base_row[122usize])
                        + (BFieldElement::from_raw_u64(12579737103870920763u64)))))
                + ((node_238)
                    * ((base_row[122usize])
                        + (BFieldElement::from_raw_u64(17082569335437832789u64)))))
                + ((node_245)
                    * ((base_row[122usize])
                        + (BFieldElement::from_raw_u64(14165256104883557753u64)))),
            (((((node_102)
                * ((base_row[123usize])
                    + (BFieldElement::from_raw_u64(6968886508437513677u64))))
                + ((node_221)
                    * ((base_row[123usize])
                        + (BFieldElement::from_raw_u64(615596267195055952u64)))))
                + ((base_row[155usize])
                    * ((base_row[123usize])
                        + (BFieldElement::from_raw_u64(10119826060478909841u64)))))
                + ((node_238)
                    * ((base_row[123usize])
                        + (BFieldElement::from_raw_u64(229051680548583225u64)))))
                + ((node_245)
                    * ((base_row[123usize])
                        + (BFieldElement::from_raw_u64(15283356519694111298u64)))),
            (((((node_102)
                * ((base_row[124usize])
                    + (BFieldElement::from_raw_u64(9713264609690967820u64))))
                + ((node_221)
                    * ((base_row[124usize])
                        + (BFieldElement::from_raw_u64(18227830850447556704u64)))))
                + ((base_row[155usize])
                    * ((base_row[124usize])
                        + (BFieldElement::from_raw_u64(1528714547662620921u64)))))
                + ((node_238)
                    * ((base_row[124usize])
                        + (BFieldElement::from_raw_u64(2943254981416254648u64)))))
                + ((node_245)
                    * ((base_row[124usize])
                        + (BFieldElement::from_raw_u64(2306049938060341466u64)))),
            (((((node_102)
                * ((base_row[125usize])
                    + (BFieldElement::from_raw_u64(12482374976099749513u64))))
                + ((node_221)
                    * ((base_row[125usize])
                        + (BFieldElement::from_raw_u64(15609691041895848348u64)))))
                + ((base_row[155usize])
                    * ((base_row[125usize])
                        + (BFieldElement::from_raw_u64(12972275929555275935u64)))))
                + ((node_238)
                    * ((base_row[125usize])
                        + (BFieldElement::from_raw_u64(5767629304344025219u64)))))
                + ((node_245)
                    * ((base_row[125usize])
                        + (BFieldElement::from_raw_u64(11578793764462375094u64)))),
            (((((node_102)
                * ((base_row[126usize])
                    + (BFieldElement::from_raw_u64(13209711277645656680u64))))
                + ((node_221)
                    * ((base_row[126usize])
                        + (BFieldElement::from_raw_u64(15235800289984546486u64)))))
                + ((base_row[155usize])
                    * ((base_row[126usize])
                        + (BFieldElement::from_raw_u64(15992731669612695172u64)))))
                + ((node_238)
                    * ((base_row[126usize])
                        + (BFieldElement::from_raw_u64(16721422493821450473u64)))))
                + ((node_245)
                    * ((base_row[126usize])
                        + (BFieldElement::from_raw_u64(7511767364422267184u64)))),
            (((((node_102)
                * ((base_row[127usize])
                    + (BFieldElement::from_raw_u64(87705059284758253u64))))
                + ((node_221)
                    * ((base_row[127usize])
                        + (BFieldElement::from_raw_u64(11392407538241985753u64)))))
                + ((base_row[155usize])
                    * ((base_row[127usize])
                        + (BFieldElement::from_raw_u64(17877154195438905917u64)))))
                + ((node_238)
                    * ((base_row[127usize])
                        + (BFieldElement::from_raw_u64(5753720429376839714u64)))))
                + ((node_245)
                    * ((base_row[127usize])
                        + (BFieldElement::from_raw_u64(16999805755930336630u64)))),
            (((((node_102)
                * ((base_row[128usize])
                    + (BFieldElement::from_raw_u64(330155256278907084u64))))
                + ((node_221)
                    * ((base_row[128usize])
                        + (BFieldElement::from_raw_u64(11776128816341368822u64)))))
                + ((base_row[155usize])
                    * ((base_row[128usize])
                        + (BFieldElement::from_raw_u64(939319986782105612u64)))))
                + ((node_238)
                    * ((base_row[128usize])
                        + (BFieldElement::from_raw_u64(2063756830275051942u64)))))
                + ((node_245)
                    * ((base_row[128usize])
                        + (BFieldElement::from_raw_u64(940614108343834936u64)))),
            (base_row[129usize])
                * ((BFieldElement::from_raw_u64(4294967295u64))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (base_row[129usize]))),
            (base_row[135usize])
                * ((BFieldElement::from_raw_u64(4294967295u64))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (base_row[135usize]))),
            (base_row[139usize])
                * ((BFieldElement::from_raw_u64(4294967295u64))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (base_row[139usize]))),
            (base_row[139usize]) * (base_row[140usize]),
            (BFieldElement::from_raw_u64(4294967295u64))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((base_row[141usize])
                        * ((base_row[140usize])
                            + (BFieldElement::from_raw_u64(18446743927680663586u64))))),
            (base_row[144usize]) * (node_655),
            (base_row[143usize]) * (node_655),
            (base_row[146usize]) * (node_660),
            (base_row[145usize]) * (node_660),
            (base_row[167usize])
                * ((base_row[147usize])
                    + (BFieldElement::from_raw_u64(18446744060824649731u64))),
            (base_row[168usize]) * (base_row[147usize]),
            (((base_row[163usize]) * (node_655)) * (node_660)) * (base_row[147usize]),
            (((base_row[166usize]) * (node_678)) * (node_660))
                * ((base_row[147usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))),
            (((base_row[164usize]) * (node_680)) * (node_655))
                * ((base_row[147usize]) + (BFieldElement::from_raw_u64(4294967295u64))),
            (((base_row[166usize]) * (node_674)) * (node_655)) * (base_row[147usize]),
            ((base_row[164usize]) * (base_row[139usize])) * (node_655),
            (node_680) * (base_row[148usize]),
            (base_row[151usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((base_row[64usize]) * (node_89))),
            (base_row[152usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((node_89) * (node_90)) * (node_94)) * (node_97))),
            (base_row[153usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((base_row[64usize]) * (node_90)) * (node_94)) * (node_97))),
            (base_row[154usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((base_row[151usize]) * (node_90))),
            (base_row[155usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((base_row[151usize]) * (node_94)) * (node_97)) * (node_101))),
            (base_row[156usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_663)
                        * ((base_row[142usize])
                            + (BFieldElement::from_raw_u64(18446744043644780551u64))))),
            (base_row[157usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((base_row[143usize]) * (base_row[144usize]))),
            (base_row[158usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((node_663) * (node_666)) * (node_670)) * (node_674))),
            (base_row[159usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((base_row[156usize]) * (node_666))),
            (base_row[160usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((base_row[145usize]) * (base_row[146usize]))),
            (base_row[161usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_86) * (base_row[62usize]))),
            (base_row[162usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((base_row[158usize]) * (node_678))),
            (base_row[163usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((base_row[156usize]) * (node_670)) * (node_674)) * (node_678))),
            (base_row[164usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((base_row[159usize]) * (node_674)) * (node_678))),
            (base_row[165usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((node_83) * (node_103)) * (base_row[62usize]))
                        * ((base_row[63usize])
                            + (BFieldElement::from_raw_u64(18446743897615892521u64))))),
            (base_row[166usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((base_row[159usize]) * (node_670))),
            (base_row[167usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((base_row[162usize]) * (node_680)) * (node_655)) * (node_660))),
            (base_row[168usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((base_row[162usize]) * (base_row[139usize])) * (node_655))
                        * (node_660))),
        ];
        let ext_constraints = [];
        base_constraints.into_iter().chain(ext_constraints).collect()
    }
    #[allow(unused_variables)]
    fn evaluate_transition_constraints(
        current_base_row: ArrayView1<XFieldElement>,
        current_ext_row: ArrayView1<XFieldElement>,
        next_base_row: ArrayView1<XFieldElement>,
        next_ext_row: ArrayView1<XFieldElement>,
        challenges: &Challenges,
    ) -> Vec<XFieldElement> {
        let node_120 = (next_base_row[19usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[19usize]));
        let node_520 = (next_ext_row[3usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[3usize]));
        let node_524 = (next_ext_row[4usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[4usize]));
        let node_124 = (next_base_row[20usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[20usize]));
        let node_128 = (next_base_row[21usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[21usize]));
        let node_516 = (next_ext_row[7usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[7usize]));
        let node_2311 = (current_base_row[18usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_3926 = (BFieldElement::from_raw_u64(4294967295u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (next_base_row[8usize]));
        let node_261 = (next_base_row[38usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[38usize]));
        let node_1182 = ((next_base_row[9usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[9usize])))
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_2309 = (current_base_row[17usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_612 = (challenges[40usize]) * (current_base_row[30usize]);
        let node_614 = (challenges[41usize]) * (current_base_row[31usize]);
        let node_616 = (challenges[42usize]) * (current_base_row[32usize]);
        let node_618 = (challenges[43usize]) * (current_base_row[33usize]);
        let node_620 = (challenges[44usize]) * (current_base_row[34usize]);
        let node_622 = (challenges[45usize]) * (current_base_row[35usize]);
        let node_624 = (challenges[46usize]) * (current_base_row[36usize]);
        let node_861 = (challenges[47usize]) * (current_base_row[37usize]);
        let node_608 = (challenges[38usize]) * (current_base_row[28usize]);
        let node_610 = (challenges[39usize]) * (current_base_row[29usize]);
        let node_1177 = (next_ext_row[6usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[6usize]));
        let node_272 = ((challenges[16usize]) * (current_base_row[7usize]))
            + ((challenges[17usize]) * (current_base_row[13usize]));
        let node_606 = (challenges[37usize]) * (current_base_row[27usize]);
        let node_602 = (challenges[35usize]) * (current_base_row[25usize]);
        let node_604 = (challenges[36usize]) * (current_base_row[26usize]);
        let node_600 = (challenges[34usize]) * (current_base_row[24usize]);
        let node_5592 = (current_base_row[294usize])
            * ((next_base_row[64usize])
                + (BFieldElement::from_raw_u64(18446744052234715141u64)));
        let node_860 = ((((((((((((((((challenges[32usize]) * (next_base_row[22usize]))
            + ((challenges[33usize]) * (next_base_row[23usize])))
            + ((challenges[34usize]) * (next_base_row[24usize])))
            + ((challenges[35usize]) * (next_base_row[25usize])))
            + ((challenges[36usize]) * (next_base_row[26usize])))
            + ((challenges[37usize]) * (next_base_row[27usize])))
            + ((challenges[38usize]) * (next_base_row[28usize])))
            + ((challenges[39usize]) * (next_base_row[29usize])))
            + ((challenges[40usize]) * (next_base_row[30usize])))
            + ((challenges[41usize]) * (next_base_row[31usize])))
            + ((challenges[42usize]) * (next_base_row[32usize])))
            + ((challenges[43usize]) * (next_base_row[33usize])))
            + ((challenges[44usize]) * (next_base_row[34usize])))
            + ((challenges[45usize]) * (next_base_row[35usize])))
            + ((challenges[46usize]) * (next_base_row[36usize])))
            + ((challenges[47usize]) * (next_base_row[37usize]));
        let node_598 = (challenges[33usize]) * (current_base_row[23usize]);
        let node_5669 = (((next_base_row[63usize])
            + (BFieldElement::from_raw_u64(18446743992105173011u64)))
            * ((next_base_row[63usize])
                + (BFieldElement::from_raw_u64(18446743923385696291u64))))
            * ((next_base_row[63usize])
                + (BFieldElement::from_raw_u64(18446743828896415801u64)));
        let node_4646 = (((((current_base_row[81usize])
            * (BFieldElement::from_raw_u64(18446744069414518785u64)))
            + ((current_base_row[82usize])
                * (BFieldElement::from_raw_u64(18446744069414584320u64))))
            + ((current_base_row[83usize])
                * (BFieldElement::from_raw_u64(281474976645120u64))))
            + (current_base_row[84usize])) * (BFieldElement::from_raw_u64(1u64));
        let node_4657 = (((((current_base_row[85usize])
            * (BFieldElement::from_raw_u64(18446744069414518785u64)))
            + ((current_base_row[86usize])
                * (BFieldElement::from_raw_u64(18446744069414584320u64))))
            + ((current_base_row[87usize])
                * (BFieldElement::from_raw_u64(281474976645120u64))))
            + (current_base_row[88usize])) * (BFieldElement::from_raw_u64(1u64));
        let node_4668 = (((((current_base_row[89usize])
            * (BFieldElement::from_raw_u64(18446744069414518785u64)))
            + ((current_base_row[90usize])
                * (BFieldElement::from_raw_u64(18446744069414584320u64))))
            + ((current_base_row[91usize])
                * (BFieldElement::from_raw_u64(281474976645120u64))))
            + (current_base_row[92usize])) * (BFieldElement::from_raw_u64(1u64));
        let node_4679 = (((((current_base_row[93usize])
            * (BFieldElement::from_raw_u64(18446744069414518785u64)))
            + ((current_base_row[94usize])
                * (BFieldElement::from_raw_u64(18446744069414584320u64))))
            + ((current_base_row[95usize])
                * (BFieldElement::from_raw_u64(281474976645120u64))))
            + (current_base_row[96usize])) * (BFieldElement::from_raw_u64(1u64));
        let node_1274 = ((current_base_row[7usize]) * (challenges[20usize]))
            + (challenges[23usize]);
        let node_810 = (next_base_row[22usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[22usize]));
        let node_538 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_base_row[27usize]);
        let node_536 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_base_row[26usize]);
        let node_540 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_base_row[28usize]);
        let node_542 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_base_row[29usize]);
        let node_2307 = (current_base_row[16usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_534 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_base_row[25usize]);
        let node_544 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_base_row[30usize]);
        let node_546 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_base_row[31usize]);
        let node_548 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_base_row[32usize]);
        let node_116 = ((next_base_row[9usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[9usize])))
            + (BFieldElement::from_raw_u64(18446744060824649731u64));
        let node_1232 = (next_base_row[25usize]) + (node_536);
        let node_1233 = (next_base_row[26usize]) + (node_538);
        let node_1234 = (next_base_row[27usize]) + (node_540);
        let node_1235 = (next_base_row[28usize]) + (node_542);
        let node_1236 = (next_base_row[29usize]) + (node_544);
        let node_1237 = (next_base_row[30usize]) + (node_546);
        let node_262 = (node_261) + (BFieldElement::from_raw_u64(4294967295u64));
        let node_1238 = (next_base_row[31usize]) + (node_548);
        let node_1239 = (next_base_row[32usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[33usize]));
        let node_1240 = (next_base_row[33usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[34usize]));
        let node_1241 = (next_base_row[34usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[35usize]));
        let node_1242 = (next_base_row[35usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[36usize]));
        let node_1243 = (next_base_row[36usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[37usize]));
        let node_286 = (next_ext_row[6usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((current_ext_row[6usize])
                    * ((challenges[7usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((node_272)
                                + ((challenges[18usize]) * (next_base_row[38usize])))
                                + ((challenges[19usize]) * (next_base_row[37usize])))))));
        let node_6058 = (next_base_row[139usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_550 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_base_row[33usize]);
        let node_1230 = (next_base_row[23usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[24usize]));
        let node_1231 = (next_base_row[24usize]) + (node_534);
        let node_4413 = (BFieldElement::from_raw_u64(4294967295u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (((next_base_row[52usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_base_row[52usize]))) * (current_base_row[54usize])));
        let node_4075 = (BFieldElement::from_raw_u64(4294967295u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (next_base_row[44usize]));
        let node_530 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_base_row[23usize]);
        let node_532 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_base_row[24usize]);
        let node_552 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_base_row[34usize]);
        let node_864 = (node_860)
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (((((((((((((((((challenges[32usize]) * (current_base_row[22usize]))
                    + (node_598)) + (node_600)) + (node_602)) + (node_604)) + (node_606))
                    + (node_608)) + (node_610)) + (node_612)) + (node_614)) + (node_616))
                    + (node_618)) + (node_620)) + (node_622)) + (node_624))
                    + (node_861)));
        let node_554 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_base_row[35usize]);
        let node_154 = ((((current_base_row[11usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((BFieldElement::from_raw_u64(34359738360u64))
                    * (current_base_row[42usize]))))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((BFieldElement::from_raw_u64(17179869180u64))
                    * (current_base_row[41usize]))))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((BFieldElement::from_raw_u64(8589934590u64))
                    * (current_base_row[40usize]))))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[39usize]));
        let node_341 = (BFieldElement::from_raw_u64(4294967295u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[39usize]));
        let node_556 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_base_row[36usize]);
        let node_209 = (challenges[40usize]) * (next_base_row[30usize]);
        let node_212 = (challenges[41usize]) * (next_base_row[31usize]);
        let node_215 = (challenges[42usize]) * (next_base_row[32usize]);
        let node_218 = (challenges[43usize]) * (next_base_row[33usize]);
        let node_221 = (challenges[44usize]) * (next_base_row[34usize]);
        let node_224 = (challenges[45usize]) * (next_base_row[35usize]);
        let node_227 = (challenges[46usize]) * (next_base_row[36usize]);
        let node_859 = (challenges[47usize]) * (next_base_row[37usize]);
        let node_4282 = (next_ext_row[12usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[12usize]));
        let node_4410 = (next_base_row[52usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[52usize]));
        let node_5435 = (next_base_row[62usize])
            + (BFieldElement::from_raw_u64(18446744056529682436u64));
        let node_6054 = (current_base_row[145usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((BFieldElement::from_raw_u64(8589934590u64))
                    * (next_base_row[145usize])));
        let node_854 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_base_row[37usize]);
        let node_203 = (challenges[38usize]) * (next_base_row[28usize]);
        let node_206 = (challenges[39usize]) * (next_base_row[29usize]);
        let node_512 = ((((((((((current_base_row[283usize])
            + (current_base_row[284usize])) + (current_base_row[285usize]))
            + (current_base_row[286usize])) + (current_base_row[287usize]))
            + (current_base_row[288usize])) + (current_base_row[289usize]))
            + (current_base_row[290usize])) + (current_base_row[291usize]))
            + (current_base_row[292usize])) + (current_base_row[293usize]);
        let node_6051 = (current_base_row[143usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((BFieldElement::from_raw_u64(8589934590u64))
                    * (next_base_row[143usize])));
        let node_2305 = (current_base_row[15usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_1272 = (current_base_row[7usize]) * (challenges[20usize]);
        let node_525 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_base_row[11usize]);
        let node_200 = (challenges[37usize]) * (next_base_row[27usize]);
        let node_2049 = (challenges[1usize]) * (current_ext_row[3usize]);
        let node_5439 = (next_base_row[63usize])
            + (BFieldElement::from_raw_u64(18446743897615892521u64));
        let node_1184 = (current_base_row[279usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_1255 = (BFieldElement::from_raw_u64(4294967295u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[271usize]));
        let node_528 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_base_row[22usize]);
        let node_113 = (next_base_row[9usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[9usize]));
        let node_531 = (next_base_row[24usize]) + (node_530);
        let node_533 = (next_base_row[25usize]) + (node_532);
        let node_535 = (next_base_row[26usize]) + (node_534);
        let node_537 = (next_base_row[27usize]) + (node_536);
        let node_194 = (challenges[35usize]) * (next_base_row[25usize]);
        let node_197 = (challenges[36usize]) * (next_base_row[26usize]);
        let node_539 = (next_base_row[28usize]) + (node_538);
        let node_1909 = ((((((((((((((((challenges[33usize]) * (next_base_row[23usize]))
            + ((challenges[34usize]) * (next_base_row[24usize]))) + (node_194))
            + (node_197)) + (node_200)) + (node_203)) + (node_206)) + (node_209))
            + (node_212)) + (node_215)) + (node_218)) + (node_221)) + (node_224))
            + (node_227)) + (node_859))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (((((((((((((((node_598) + (node_600)) + (node_602)) + (node_604))
                    + (node_606)) + (node_608)) + (node_610)) + (node_612)) + (node_614))
                    + (node_616)) + (node_618)) + (node_620)) + (node_622)) + (node_624))
                    + (node_861)));
        let node_541 = (next_base_row[29usize]) + (node_540);
        let node_543 = (next_base_row[30usize]) + (node_542);
        let node_545 = (next_base_row[31usize]) + (node_544);
        let node_558 = (node_261)
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_547 = (next_base_row[32usize]) + (node_546);
        let node_549 = (next_base_row[33usize]) + (node_548);
        let node_551 = (next_base_row[34usize]) + (node_550);
        let node_553 = (next_base_row[35usize]) + (node_552);
        let node_555 = (next_base_row[36usize]) + (node_554);
        let node_557 = (next_base_row[37usize]) + (node_556);
        let node_567 = (next_ext_row[6usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((current_ext_row[6usize])
                    * ((challenges[7usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((node_272)
                                + ((challenges[18usize]) * (current_base_row[38usize])))
                                + ((challenges[19usize])
                                    * (current_base_row[37usize])))))));
        let node_5306 = (((((next_base_row[65usize])
            * (BFieldElement::from_raw_u64(18446744069414518785u64)))
            + ((next_base_row[66usize])
                * (BFieldElement::from_raw_u64(18446744069414584320u64))))
            + ((next_base_row[67usize])
                * (BFieldElement::from_raw_u64(281474976645120u64))))
            + (next_base_row[68usize])) * (BFieldElement::from_raw_u64(1u64));
        let node_5317 = (((((next_base_row[69usize])
            * (BFieldElement::from_raw_u64(18446744069414518785u64)))
            + ((next_base_row[70usize])
                * (BFieldElement::from_raw_u64(18446744069414584320u64))))
            + ((next_base_row[71usize])
                * (BFieldElement::from_raw_u64(281474976645120u64))))
            + (next_base_row[72usize])) * (BFieldElement::from_raw_u64(1u64));
        let node_5328 = (((((next_base_row[73usize])
            * (BFieldElement::from_raw_u64(18446744069414518785u64)))
            + ((next_base_row[74usize])
                * (BFieldElement::from_raw_u64(18446744069414584320u64))))
            + ((next_base_row[75usize])
                * (BFieldElement::from_raw_u64(281474976645120u64))))
            + (next_base_row[76usize])) * (BFieldElement::from_raw_u64(1u64));
        let node_5339 = (((((next_base_row[77usize])
            * (BFieldElement::from_raw_u64(18446744069414518785u64)))
            + ((next_base_row[78usize])
                * (BFieldElement::from_raw_u64(18446744069414584320u64))))
            + ((next_base_row[79usize])
                * (BFieldElement::from_raw_u64(281474976645120u64))))
            + (next_base_row[80usize])) * (BFieldElement::from_raw_u64(1u64));
        let node_5430 = (next_base_row[62usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_5998 = (BFieldElement::from_raw_u64(4294967295u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (next_base_row[135usize]));
        let node_6085 = (next_base_row[142usize])
            + (BFieldElement::from_raw_u64(18446743940565565471u64));
        let node_2303 = (current_base_row[14usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_293 = (BFieldElement::from_raw_u64(4294967295u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[40usize]));
        let node_6089 = (next_base_row[142usize])
            + (BFieldElement::from_raw_u64(18446743949155500061u64));
        let node_34 = (BFieldElement::from_raw_u64(4294967295u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((current_base_row[4usize])
                    * ((BFieldElement::from_raw_u64(38654705655u64))
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (current_base_row[3usize])))));
        let node_812 = (next_base_row[22usize]) + (node_530);
        let node_1918 = (BFieldElement::from_raw_u64(4294967295u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[322usize]));
        let node_1970 = (next_base_row[24usize]) + (node_532);
        let node_2186 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (next_ext_row[7usize]);
        let node_1585 = (next_base_row[25usize]) + (node_540);
        let node_1586 = (next_base_row[26usize]) + (node_542);
        let node_191 = (challenges[34usize]) * (next_base_row[24usize]);
        let node_1587 = (next_base_row[27usize]) + (node_544);
        let node_1588 = (next_base_row[28usize]) + (node_546);
        let node_1820 = (((((((((((node_200) + (node_203)) + (node_206)) + (node_209))
            + (node_212)) + (node_215)) + (node_218)) + (node_221)) + (node_224))
            + (node_227)) + (node_859))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (((((((((((node_606) + (node_608)) + (node_610)) + (node_612))
                    + (node_614)) + (node_616)) + (node_618)) + (node_620)) + (node_622))
                    + (node_624)) + (node_861)));
        let node_1589 = (next_base_row[29usize]) + (node_548);
        let node_1590 = (next_base_row[30usize]) + (node_550);
        let node_476 = (((((current_base_row[195usize]) * (node_262))
            + ((current_base_row[196usize])
                * ((node_261) + (BFieldElement::from_raw_u64(8589934590u64)))))
            + ((current_base_row[197usize])
                * ((node_261) + (BFieldElement::from_raw_u64(12884901885u64)))))
            + ((current_base_row[198usize])
                * ((node_261) + (BFieldElement::from_raw_u64(17179869180u64)))))
            + ((current_base_row[199usize])
                * ((node_261) + (BFieldElement::from_raw_u64(21474836475u64))));
        let node_801 = (((((current_base_row[195usize]) * (node_558))
            + ((current_base_row[196usize])
                * ((node_261) + (BFieldElement::from_raw_u64(18446744060824649731u64)))))
            + ((current_base_row[197usize])
                * ((node_261) + (BFieldElement::from_raw_u64(18446744056529682436u64)))))
            + ((current_base_row[198usize])
                * ((node_261) + (BFieldElement::from_raw_u64(18446744052234715141u64)))))
            + ((current_base_row[199usize])
                * ((node_261) + (BFieldElement::from_raw_u64(18446744047939747846u64))));
        let node_455 = (node_261) + (BFieldElement::from_raw_u64(21474836475u64));
        let node_1591 = (next_base_row[31usize]) + (node_552);
        let node_1592 = (next_base_row[32usize]) + (node_554);
        let node_484 = ((((current_ext_row[74usize]) + (current_ext_row[75usize]))
            + (current_ext_row[76usize])) + (current_ext_row[77usize]))
            + ((current_base_row[199usize])
                * ((next_ext_row[6usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_ext_row[59usize]))));
        let node_809 = ((((current_ext_row[78usize]) + (current_ext_row[79usize]))
            + (current_ext_row[80usize])) + (current_ext_row[81usize]))
            + (current_ext_row[82usize]);
        let node_468 = (next_ext_row[6usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[59usize]));
        let node_1593 = (next_base_row[33usize]) + (node_556);
        let node_1594 = (next_base_row[34usize]) + (node_854);
        let node_372 = (node_261) + (BFieldElement::from_raw_u64(12884901885u64));
        let node_385 = (next_ext_row[6usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((current_ext_row[6usize]) * (current_ext_row[52usize])));
        let node_4048 = (next_base_row[18usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_4193 = ((next_ext_row[11usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((challenges[6usize]) * (current_ext_row[11usize]))))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((challenges[31usize]) * (current_base_row[10usize])));
        let node_4239 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * ((challenges[57usize]) * (current_base_row[10usize]));
        let node_4286 = ((node_4282)
            * (((((challenges[10usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((challenges[55usize]) * (current_base_row[22usize]))))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((challenges[56usize]) * (current_base_row[23usize]))))
                + (node_4239))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((challenges[58usize]) * (next_base_row[22usize])))))
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_4243 = (challenges[10usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((challenges[55usize]) * (current_base_row[22usize])));
        let node_4336 = ((next_base_row[48usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[48usize])))
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_4335 = (next_base_row[48usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[48usize]));
        let node_4342 = (next_base_row[47usize])
            + (BFieldElement::from_raw_u64(18446744060824649731u64));
        let node_4368 = (next_ext_row[15usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[15usize]));
        let node_4405 = (next_base_row[51usize])
            + (BFieldElement::from_raw_u64(18446744060824649731u64));
        let node_4488 = (next_ext_row[21usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[21usize]));
        let node_4517 = ((next_base_row[59usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[59usize])))
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_4516 = (next_base_row[59usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[59usize]));
        let node_4524 = ((node_4517)
            * ((current_base_row[58usize])
                + (BFieldElement::from_raw_u64(18446744000695107601u64))))
            * ((current_base_row[58usize])
                + (BFieldElement::from_raw_u64(18446743931975630881u64)));
        let node_5427 = (current_base_row[62usize])
            + (BFieldElement::from_raw_u64(18446744056529682436u64));
        let node_5491 = (next_base_row[64usize])
            + (BFieldElement::from_raw_u64(18446744047939747846u64));
        let node_5542 = (next_base_row[63usize])
            + (BFieldElement::from_raw_u64(18446743992105173011u64));
        let node_5544 = (next_base_row[63usize])
            + (BFieldElement::from_raw_u64(18446743923385696291u64));
        let node_5661 = (next_ext_row[28usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[28usize]));
        let node_5682 = (next_ext_row[29usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[29usize]));
        let node_5699 = (next_ext_row[30usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[30usize]));
        let node_5716 = (next_ext_row[31usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[31usize]));
        let node_5733 = (next_ext_row[32usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[32usize]));
        let node_5750 = (next_ext_row[33usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[33usize]));
        let node_5767 = (next_ext_row[34usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[34usize]));
        let node_5784 = (next_ext_row[35usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[35usize]));
        let node_5801 = (next_ext_row[36usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[36usize]));
        let node_5818 = (next_ext_row[37usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[37usize]));
        let node_5835 = (next_ext_row[38usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[38usize]));
        let node_5852 = (next_ext_row[39usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[39usize]));
        let node_5869 = (next_ext_row[40usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[40usize]));
        let node_5886 = (next_ext_row[41usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[41usize]));
        let node_5903 = (next_ext_row[42usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[42usize]));
        let node_5920 = (next_ext_row[43usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[43usize]));
        let node_5946 = (BFieldElement::from_raw_u64(4294967295u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (next_base_row[129usize]));
        let node_6048 = (current_base_row[142usize])
            + (BFieldElement::from_raw_u64(18446743940565565471u64));
        let node_6075 = (node_6054)
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_6083 = (next_base_row[142usize])
            + (BFieldElement::from_raw_u64(18446744017874976781u64));
        let node_5451 = (next_base_row[62usize])
            + (BFieldElement::from_raw_u64(18446744060824649731u64));
        let node_2159 = (current_base_row[40usize]) * (challenges[22usize]);
        let node_2166 = (current_base_row[41usize]) * (challenges[22usize]);
        let node_2173 = (current_base_row[42usize]) * (challenges[22usize]);
        let node_30 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_base_row[3usize]);
        let node_47 = (next_base_row[6usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_51 = (next_ext_row[0usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[0usize]));
        let node_31 = (BFieldElement::from_raw_u64(38654705655u64)) + (node_30);
        let node_74 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (next_base_row[1usize]);
        let node_90 = (BFieldElement::from_raw_u64(38654705655u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (next_base_row[3usize]));
        let node_88 = (next_ext_row[2usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[2usize]));
        let node_229 = (challenges[32usize]) * (current_base_row[23usize]);
        let node_299 = (challenges[32usize]) * (current_base_row[24usize]);
        let node_346 = (challenges[32usize]) * (current_base_row[25usize]);
        let node_390 = (challenges[32usize]) * (current_base_row[26usize]);
        let node_433 = (challenges[32usize]) * (current_base_row[27usize]);
        let node_1050 = (challenges[32usize]) * (current_base_row[32usize]);
        let node_1181 = (next_base_row[10usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[10usize]));
        let node_1249 = (node_120) + (BFieldElement::from_raw_u64(4294967295u64));
        let node_1251 = (next_base_row[9usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[21usize]));
        let node_1912 = (next_base_row[22usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((current_base_row[22usize]) * (current_base_row[23usize])));
        let node_1913 = (next_base_row[22usize]) * (current_base_row[22usize]);
        let node_1934 = (current_base_row[23usize]) * (next_base_row[23usize]);
        let node_1937 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (next_base_row[22usize]);
        let node_1972 = (current_base_row[22usize]) * (current_base_row[25usize]);
        let node_1983 = ((current_base_row[24usize]) * (current_base_row[26usize]))
            + ((current_base_row[23usize]) * (current_base_row[27usize]));
        let node_1997 = (current_base_row[24usize]) * (next_base_row[23usize]);
        let node_2000 = (current_base_row[23usize]) * (next_base_row[24usize]);
        let node_1571 = (node_810)
            + (BFieldElement::from_raw_u64(18446744056529682436u64));
        let node_1505 = (node_810)
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_529 = (next_base_row[23usize]) + (node_528);
        let node_112 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_base_row[9usize]);
        let node_1250 = (next_base_row[9usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[20usize]));
        let node_1252 = (current_base_row[28usize]) + (node_538);
        let node_1915 = (current_base_row[23usize]) + (node_528);
        let node_1968 = (next_base_row[23usize]) + (node_530);
        let node_2126 = (((BFieldElement::from_raw_u64(8589934590u64))
            * (next_base_row[27usize])) + (current_base_row[44usize])) + (node_538);
        let node_2210 = (node_1968)
            + (BFieldElement::from_raw_u64(18446744056529682436u64));
        let node_292 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_base_row[40usize]);
        let node_144 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * ((BFieldElement::from_raw_u64(34359738360u64))
                * (current_base_row[42usize]));
        let node_2258 = ((current_base_row[41usize]) * (current_base_row[43usize]))
            + ((current_base_row[40usize]) * (current_base_row[44usize]));
        let node_1661 = (next_base_row[27usize]) + (node_548);
        let node_2268 = (next_base_row[25usize]) + (node_534);
        let node_2259 = (current_base_row[41usize]) * (current_base_row[44usize]);
        let node_1662 = (next_base_row[28usize]) + (node_550);
        let node_201 = ((((((challenges[32usize]) * (next_base_row[22usize]))
            + ((challenges[33usize]) * (next_base_row[23usize]))) + (node_191))
            + (node_194)) + (node_197)) + (node_200);
        let node_607 = ((((((challenges[32usize]) * (current_base_row[22usize]))
            + (node_598)) + (node_600)) + (node_602)) + (node_604)) + (node_606);
        let node_2271 = (next_base_row[26usize]) + (node_536);
        let node_1663 = (next_base_row[29usize]) + (node_552);
        let node_1664 = (next_base_row[30usize]) + (node_554);
        let node_1665 = (next_base_row[31usize]) + (node_556);
        let node_1666 = (next_base_row[32usize]) + (node_854);
        let node_480 = (((((current_base_row[195usize])
            * (((((((((((node_201) + (node_203)) + (node_206)) + (node_209))
                + (node_212)) + (node_215)) + (node_218)) + (node_221)) + (node_224))
                + (node_227))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((((((((((((((node_229)
                        + ((challenges[33usize]) * (current_base_row[24usize])))
                        + ((challenges[34usize]) * (current_base_row[25usize])))
                        + ((challenges[35usize]) * (current_base_row[26usize])))
                        + ((challenges[36usize]) * (current_base_row[27usize])))
                        + ((challenges[37usize]) * (current_base_row[28usize])))
                        + ((challenges[38usize]) * (current_base_row[29usize])))
                        + ((challenges[39usize]) * (current_base_row[30usize])))
                        + ((challenges[40usize]) * (current_base_row[31usize])))
                        + ((challenges[41usize]) * (current_base_row[32usize])))
                        + ((challenges[42usize]) * (current_base_row[33usize])))
                        + ((challenges[43usize]) * (current_base_row[34usize])))
                        + ((challenges[44usize]) * (current_base_row[35usize])))
                        + ((challenges[45usize]) * (current_base_row[36usize])))
                        + ((challenges[46usize]) * (current_base_row[37usize]))))))
            + ((current_base_row[196usize])
                * ((((((((((node_201) + (node_203)) + (node_206)) + (node_209))
                    + (node_212)) + (node_215)) + (node_218)) + (node_221)) + (node_224))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((((((((((((((node_299)
                            + ((challenges[33usize]) * (current_base_row[25usize])))
                            + ((challenges[34usize]) * (current_base_row[26usize])))
                            + ((challenges[35usize]) * (current_base_row[27usize])))
                            + ((challenges[36usize]) * (current_base_row[28usize])))
                            + ((challenges[37usize]) * (current_base_row[29usize])))
                            + ((challenges[38usize]) * (current_base_row[30usize])))
                            + ((challenges[39usize]) * (current_base_row[31usize])))
                            + ((challenges[40usize]) * (current_base_row[32usize])))
                            + ((challenges[41usize]) * (current_base_row[33usize])))
                            + ((challenges[42usize]) * (current_base_row[34usize])))
                            + ((challenges[43usize]) * (current_base_row[35usize])))
                            + ((challenges[44usize]) * (current_base_row[36usize])))
                            + ((challenges[45usize]) * (current_base_row[37usize])))))))
            + ((current_base_row[197usize])
                * (((((((((node_201) + (node_203)) + (node_206)) + (node_209))
                    + (node_212)) + (node_215)) + (node_218)) + (node_221))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (((((((((((((node_346)
                            + ((challenges[33usize]) * (current_base_row[26usize])))
                            + ((challenges[34usize]) * (current_base_row[27usize])))
                            + ((challenges[35usize]) * (current_base_row[28usize])))
                            + ((challenges[36usize]) * (current_base_row[29usize])))
                            + ((challenges[37usize]) * (current_base_row[30usize])))
                            + ((challenges[38usize]) * (current_base_row[31usize])))
                            + ((challenges[39usize]) * (current_base_row[32usize])))
                            + ((challenges[40usize]) * (current_base_row[33usize])))
                            + ((challenges[41usize]) * (current_base_row[34usize])))
                            + ((challenges[42usize]) * (current_base_row[35usize])))
                            + ((challenges[43usize]) * (current_base_row[36usize])))
                            + ((challenges[44usize]) * (current_base_row[37usize])))))))
            + ((current_base_row[198usize])
                * ((((((((node_201) + (node_203)) + (node_206)) + (node_209))
                    + (node_212)) + (node_215)) + (node_218))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((((((((((((node_390)
                            + ((challenges[33usize]) * (current_base_row[27usize])))
                            + ((challenges[34usize]) * (current_base_row[28usize])))
                            + ((challenges[35usize]) * (current_base_row[29usize])))
                            + ((challenges[36usize]) * (current_base_row[30usize])))
                            + ((challenges[37usize]) * (current_base_row[31usize])))
                            + ((challenges[38usize]) * (current_base_row[32usize])))
                            + ((challenges[39usize]) * (current_base_row[33usize])))
                            + ((challenges[40usize]) * (current_base_row[34usize])))
                            + ((challenges[41usize]) * (current_base_row[35usize])))
                            + ((challenges[42usize]) * (current_base_row[36usize])))
                            + ((challenges[43usize]) * (current_base_row[37usize])))))))
            + ((current_base_row[199usize])
                * (((((((node_201) + (node_203)) + (node_206)) + (node_209))
                    + (node_212)) + (node_215))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (((((((((((node_433)
                            + ((challenges[33usize]) * (current_base_row[28usize])))
                            + ((challenges[34usize]) * (current_base_row[29usize])))
                            + ((challenges[35usize]) * (current_base_row[30usize])))
                            + ((challenges[36usize]) * (current_base_row[31usize])))
                            + ((challenges[37usize]) * (current_base_row[32usize])))
                            + ((challenges[38usize]) * (current_base_row[33usize])))
                            + ((challenges[39usize]) * (current_base_row[34usize])))
                            + ((challenges[40usize]) * (current_base_row[35usize])))
                            + ((challenges[41usize]) * (current_base_row[36usize])))
                            + ((challenges[42usize]) * (current_base_row[37usize]))))));
        let node_805 = (((((current_base_row[195usize])
            * (((((((((((((((((challenges[32usize]) * (next_base_row[23usize]))
                + ((challenges[33usize]) * (next_base_row[24usize])))
                + ((challenges[34usize]) * (next_base_row[25usize])))
                + ((challenges[35usize]) * (next_base_row[26usize])))
                + ((challenges[36usize]) * (next_base_row[27usize])))
                + ((challenges[37usize]) * (next_base_row[28usize])))
                + ((challenges[38usize]) * (next_base_row[29usize])))
                + ((challenges[39usize]) * (next_base_row[30usize])))
                + ((challenges[40usize]) * (next_base_row[31usize])))
                + ((challenges[41usize]) * (next_base_row[32usize])))
                + ((challenges[42usize]) * (next_base_row[33usize])))
                + ((challenges[43usize]) * (next_base_row[34usize])))
                + ((challenges[44usize]) * (next_base_row[35usize])))
                + ((challenges[45usize]) * (next_base_row[36usize])))
                + ((challenges[46usize]) * (next_base_row[37usize])))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((((((((node_607) + (node_608)) + (node_610)) + (node_612))
                        + (node_614)) + (node_616)) + (node_618)) + (node_620))
                        + (node_622)) + (node_624)))))
            + ((current_base_row[196usize])
                * ((((((((((((((((challenges[32usize]) * (next_base_row[24usize]))
                    + ((challenges[33usize]) * (next_base_row[25usize])))
                    + ((challenges[34usize]) * (next_base_row[26usize])))
                    + ((challenges[35usize]) * (next_base_row[27usize])))
                    + ((challenges[36usize]) * (next_base_row[28usize])))
                    + ((challenges[37usize]) * (next_base_row[29usize])))
                    + ((challenges[38usize]) * (next_base_row[30usize])))
                    + ((challenges[39usize]) * (next_base_row[31usize])))
                    + ((challenges[40usize]) * (next_base_row[32usize])))
                    + ((challenges[41usize]) * (next_base_row[33usize])))
                    + ((challenges[42usize]) * (next_base_row[34usize])))
                    + ((challenges[43usize]) * (next_base_row[35usize])))
                    + ((challenges[44usize]) * (next_base_row[36usize])))
                    + ((challenges[45usize]) * (next_base_row[37usize])))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (((((((((node_607) + (node_608)) + (node_610)) + (node_612))
                            + (node_614)) + (node_616)) + (node_618)) + (node_620))
                            + (node_622))))))
            + ((current_base_row[197usize])
                * (((((((((((((((challenges[32usize]) * (next_base_row[25usize]))
                    + ((challenges[33usize]) * (next_base_row[26usize])))
                    + ((challenges[34usize]) * (next_base_row[27usize])))
                    + ((challenges[35usize]) * (next_base_row[28usize])))
                    + ((challenges[36usize]) * (next_base_row[29usize])))
                    + ((challenges[37usize]) * (next_base_row[30usize])))
                    + ((challenges[38usize]) * (next_base_row[31usize])))
                    + ((challenges[39usize]) * (next_base_row[32usize])))
                    + ((challenges[40usize]) * (next_base_row[33usize])))
                    + ((challenges[41usize]) * (next_base_row[34usize])))
                    + ((challenges[42usize]) * (next_base_row[35usize])))
                    + ((challenges[43usize]) * (next_base_row[36usize])))
                    + ((challenges[44usize]) * (next_base_row[37usize])))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((((((((node_607) + (node_608)) + (node_610)) + (node_612))
                            + (node_614)) + (node_616)) + (node_618)) + (node_620))))))
            + ((current_base_row[198usize])
                * ((((((((((((((challenges[32usize]) * (next_base_row[26usize]))
                    + ((challenges[33usize]) * (next_base_row[27usize])))
                    + ((challenges[34usize]) * (next_base_row[28usize])))
                    + ((challenges[35usize]) * (next_base_row[29usize])))
                    + ((challenges[36usize]) * (next_base_row[30usize])))
                    + ((challenges[37usize]) * (next_base_row[31usize])))
                    + ((challenges[38usize]) * (next_base_row[32usize])))
                    + ((challenges[39usize]) * (next_base_row[33usize])))
                    + ((challenges[40usize]) * (next_base_row[34usize])))
                    + ((challenges[41usize]) * (next_base_row[35usize])))
                    + ((challenges[42usize]) * (next_base_row[36usize])))
                    + ((challenges[43usize]) * (next_base_row[37usize])))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (((((((node_607) + (node_608)) + (node_610)) + (node_612))
                            + (node_614)) + (node_616)) + (node_618))))))
            + ((current_base_row[199usize])
                * (((((((((((((challenges[32usize]) * (next_base_row[27usize]))
                    + ((challenges[33usize]) * (next_base_row[28usize])))
                    + ((challenges[34usize]) * (next_base_row[29usize])))
                    + ((challenges[35usize]) * (next_base_row[30usize])))
                    + ((challenges[36usize]) * (next_base_row[31usize])))
                    + ((challenges[37usize]) * (next_base_row[32usize])))
                    + ((challenges[38usize]) * (next_base_row[33usize])))
                    + ((challenges[39usize]) * (next_base_row[34usize])))
                    + ((challenges[40usize]) * (next_base_row[35usize])))
                    + ((challenges[41usize]) * (next_base_row[36usize])))
                    + ((challenges[42usize]) * (next_base_row[37usize])))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((((((node_607) + (node_608)) + (node_610)) + (node_612))
                            + (node_614)) + (node_616)))));
        let node_457 = ((((((node_201) + (node_203)) + (node_206)) + (node_209))
            + (node_212)) + (node_215))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (((((((((((node_433)
                    + ((challenges[33usize]) * (current_base_row[28usize])))
                    + ((challenges[34usize]) * (current_base_row[29usize])))
                    + ((challenges[35usize]) * (current_base_row[30usize])))
                    + ((challenges[36usize]) * (current_base_row[31usize])))
                    + ((challenges[37usize]) * (current_base_row[32usize])))
                    + ((challenges[38usize]) * (current_base_row[33usize])))
                    + ((challenges[39usize]) * (current_base_row[34usize])))
                    + ((challenges[40usize]) * (current_base_row[35usize])))
                    + ((challenges[41usize]) * (current_base_row[36usize])))
                    + ((challenges[42usize]) * (current_base_row[37usize]))));
        let node_2096 = ((challenges[2usize]) * (current_ext_row[4usize]))
            + (current_base_row[22usize]);
        let node_2101 = ((challenges[2usize]) * (node_2096))
            + (current_base_row[23usize]);
        let node_2106 = ((challenges[2usize]) * (node_2101))
            + (current_base_row[24usize]);
        let node_2111 = ((challenges[2usize]) * (node_2106))
            + (current_base_row[25usize]);
        let node_4002 = (next_ext_row[5usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[5usize]));
        let node_4138 = (next_ext_row[9usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((challenges[4usize]) * (current_ext_row[9usize])));
        let node_4139 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (((((node_201) + (node_203)) + (node_206)) + (node_209)) + (node_212));
        let node_4144 = (node_4138)
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (((((((((((challenges[32usize])
                    * ((current_base_row[332usize]) + (current_base_row[333usize])))
                    + ((challenges[33usize])
                        * ((current_base_row[334usize]) + (current_base_row[335usize]))))
                    + ((challenges[34usize])
                        * ((current_base_row[336usize]) + (current_base_row[337usize]))))
                    + ((challenges[35usize])
                        * ((current_base_row[338usize]) + (current_base_row[339usize]))))
                    + ((challenges[36usize])
                        * ((current_base_row[340usize]) + (current_base_row[341usize]))))
                    + ((challenges[37usize])
                        * ((current_base_row[342usize]) + (current_base_row[343usize]))))
                    + ((challenges[38usize])
                        * ((current_base_row[344usize]) + (current_base_row[345usize]))))
                    + ((challenges[39usize])
                        * ((current_base_row[346usize]) + (current_base_row[347usize]))))
                    + ((challenges[40usize])
                        * ((current_base_row[348usize]) + (current_base_row[349usize]))))
                    + ((challenges[41usize])
                        * ((current_base_row[350usize])
                            + (current_base_row[351usize])))));
        let node_198 = (((((challenges[32usize]) * (next_base_row[22usize]))
            + ((challenges[33usize]) * (next_base_row[23usize]))) + (node_191))
            + (node_194)) + (node_197);
        let node_615 = ((((node_607) + (node_608)) + (node_610)) + (node_612))
            + (node_614);
        let node_4189 = (next_ext_row[11usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((challenges[6usize]) * (current_ext_row[11usize])));
        let node_574 = ((((challenges[32usize]) * (next_base_row[23usize]))
            + ((challenges[33usize]) * (next_base_row[24usize])))
            + ((challenges[34usize]) * (next_base_row[25usize])))
            + ((challenges[35usize]) * (next_base_row[26usize]));
        let node_4232 = (challenges[10usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((challenges[55usize]) * (next_base_row[22usize])));
        let node_4235 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * ((challenges[56usize]) * (next_base_row[23usize]));
        let node_4246 = (node_4243)
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((challenges[56usize]) * (current_base_row[23usize])));
        let node_4290 = ((node_4282)
            * (((node_4243) + (node_4239))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((challenges[58usize]) * (next_base_row[22usize])))))
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_4269 = (((node_4232)
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((challenges[56usize]) * (current_base_row[23usize]))))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((challenges[57usize])
                    * (BFieldElement::from_raw_u64(25769803770u64)))))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (challenges[58usize]));
        let node_4273 = ((node_4243) + (node_4235))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * ((challenges[57usize])
                    * (BFieldElement::from_raw_u64(17179869180u64))));
        let node_4292 = ((node_4282)
            * ((((challenges[10usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((challenges[55usize]) * (current_base_row[27usize]))))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((challenges[56usize]) * (next_base_row[27usize]))))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((challenges[57usize])
                        * (BFieldElement::from_raw_u64(17179869180u64))))))
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_4359 = (next_base_row[47usize])
            * ((next_base_row[47usize])
                + (BFieldElement::from_raw_u64(18446744065119617026u64)));
        let node_4428 = (challenges[12usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (next_base_row[52usize]));
        let node_4433 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_ext_row[16usize]);
        let node_4479 = ((next_base_row[51usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64)))
            * (next_base_row[51usize]);
        let node_4553 = (next_ext_row[23usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[23usize]));
        let node_4532 = (next_base_row[57usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[57usize]));
        let node_5409 = (current_base_row[63usize])
            + (BFieldElement::from_raw_u64(18446743897615892521u64));
        let node_5411 = (current_base_row[64usize])
            + (BFieldElement::from_raw_u64(18446744047939747846u64));
        let node_5642 = (next_ext_row[24usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[24usize]));
        let node_4590 = (((((current_base_row[65usize])
            * (BFieldElement::from_raw_u64(18446744069414518785u64)))
            + ((current_base_row[66usize])
                * (BFieldElement::from_raw_u64(18446744069414584320u64))))
            + ((current_base_row[67usize])
                * (BFieldElement::from_raw_u64(281474976645120u64))))
            + (current_base_row[68usize])) * (BFieldElement::from_raw_u64(1u64));
        let node_4601 = (((((current_base_row[69usize])
            * (BFieldElement::from_raw_u64(18446744069414518785u64)))
            + ((current_base_row[70usize])
                * (BFieldElement::from_raw_u64(18446744069414584320u64))))
            + ((current_base_row[71usize])
                * (BFieldElement::from_raw_u64(281474976645120u64))))
            + (current_base_row[72usize])) * (BFieldElement::from_raw_u64(1u64));
        let node_4612 = (((((current_base_row[73usize])
            * (BFieldElement::from_raw_u64(18446744069414518785u64)))
            + ((current_base_row[74usize])
                * (BFieldElement::from_raw_u64(18446744069414584320u64))))
            + ((current_base_row[75usize])
                * (BFieldElement::from_raw_u64(281474976645120u64))))
            + (current_base_row[76usize])) * (BFieldElement::from_raw_u64(1u64));
        let node_4623 = (((((current_base_row[77usize])
            * (BFieldElement::from_raw_u64(18446744069414518785u64)))
            + ((current_base_row[78usize])
                * (BFieldElement::from_raw_u64(18446744069414584320u64))))
            + ((current_base_row[79usize])
                * (BFieldElement::from_raw_u64(281474976645120u64))))
            + (current_base_row[80usize])) * (BFieldElement::from_raw_u64(1u64));
        let node_5441 = (node_5411) * (node_5409);
        let node_5455 = ((current_base_row[62usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64)))
            * ((current_base_row[62usize])
                + (BFieldElement::from_raw_u64(18446744060824649731u64)));
        let node_5473 = (challenges[42usize])
            * ((next_base_row[103usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (current_base_row[103usize])));
        let node_5474 = (challenges[43usize])
            * ((next_base_row[104usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (current_base_row[104usize])));
        let node_5476 = (challenges[44usize])
            * ((next_base_row[105usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (current_base_row[105usize])));
        let node_5478 = (challenges[45usize])
            * ((next_base_row[106usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (current_base_row[106usize])));
        let node_5480 = (challenges[46usize])
            * ((next_base_row[107usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (current_base_row[107usize])));
        let node_5482 = (challenges[47usize])
            * ((next_base_row[108usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (current_base_row[108usize])));
        let node_5572 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (((((((((((challenges[32usize]) * (node_5306))
                + ((challenges[33usize]) * (node_5317)))
                + ((challenges[34usize]) * (node_5328)))
                + ((challenges[35usize]) * (node_5339)))
                + ((challenges[36usize]) * (next_base_row[97usize])))
                + ((challenges[37usize]) * (next_base_row[98usize])))
                + ((challenges[38usize]) * (next_base_row[99usize])))
                + ((challenges[39usize]) * (next_base_row[100usize])))
                + ((challenges[40usize]) * (next_base_row[101usize])))
                + ((challenges[41usize]) * (next_base_row[102usize])));
        let node_5549 = (next_ext_row[25usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[25usize]));
        let node_5558 = (((((challenges[32usize]) * (node_5306))
            + ((challenges[33usize]) * (node_5317)))
            + ((challenges[34usize]) * (node_5328)))
            + ((challenges[35usize]) * (node_5339)))
            + ((challenges[36usize]) * (next_base_row[97usize]));
        let node_5583 = (next_ext_row[26usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[26usize]));
        let node_5609 = (next_ext_row[27usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[27usize]));
        let node_5612 = (next_base_row[63usize])
            + (BFieldElement::from_raw_u64(18446743828896415801u64));
        let node_5956 = (next_ext_row[44usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[44usize]));
        let node_5972 = (next_ext_row[45usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[45usize]));
        let node_5967 = ((challenges[52usize]) * (next_base_row[131usize]))
            + ((challenges[53usize]) * (next_base_row[133usize]));
        let node_5970 = ((challenges[52usize]) * (next_base_row[130usize]))
            + ((challenges[53usize]) * (next_base_row[132usize]));
        let node_6010 = (next_ext_row[46usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[46usize]));
        let node_6066 = ((next_base_row[140usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[140usize])))
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_6072 = (node_6051)
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_6092 = (next_base_row[147usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_6094 = (next_base_row[147usize])
            + (BFieldElement::from_raw_u64(18446744060824649731u64));
        let node_6097 = (current_base_row[318usize]) * (next_base_row[147usize]);
        let node_6099 = (current_base_row[147usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_6064 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (current_base_row[140usize]);
        let node_6158 = (next_base_row[147usize]) * (next_base_row[147usize]);
        let node_6108 = (BFieldElement::from_raw_u64(18446744065119617026u64))
            * (node_6051);
        let node_6174 = (next_ext_row[48usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_ext_row[48usize]));
        let node_2330 = (current_base_row[12usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_2313 = (current_base_row[13usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_288 = (BFieldElement::from_raw_u64(4294967295u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[42usize]));
        let node_290 = (BFieldElement::from_raw_u64(4294967295u64))
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (current_base_row[41usize]));
        let node_5484 = (next_base_row[64usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_5485 = (next_base_row[64usize])
            + (BFieldElement::from_raw_u64(18446744060824649731u64));
        let node_5487 = (next_base_row[64usize])
            + (BFieldElement::from_raw_u64(18446744056529682436u64));
        let node_6077 = (next_base_row[142usize])
            + (BFieldElement::from_raw_u64(18446744052234715141u64));
        let node_6079 = (next_base_row[142usize])
            + (BFieldElement::from_raw_u64(18446744009285042191u64));
        let node_133 = (current_base_row[40usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_5489 = (next_base_row[64usize])
            + (BFieldElement::from_raw_u64(18446744052234715141u64));
        let node_4039 = (next_base_row[12usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_4043 = (next_base_row[15usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_4054 = (next_base_row[16usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_5426 = (current_base_row[62usize])
            + (BFieldElement::from_raw_u64(18446744060824649731u64));
        let node_5448 = (current_base_row[62usize])
            + (BFieldElement::from_raw_u64(18446744065119617026u64));
        let node_281 = (challenges[7usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (((node_272) + ((challenges[18usize]) * (next_base_row[38usize])))
                    + ((challenges[19usize]) * (next_base_row[37usize]))));
        let node_564 = (challenges[7usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (((node_272) + ((challenges[18usize]) * (current_base_row[38usize])))
                    + ((challenges[19usize]) * (current_base_row[37usize]))));
        let node_1283 = (challenges[8usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (((node_1274)
                    + (((next_base_row[22usize])
                        + (BFieldElement::from_raw_u64(4294967295u64)))
                        * (challenges[21usize])))
                    + ((next_base_row[23usize]) * (challenges[22usize]))));
        let node_1511 = (challenges[8usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (((node_1272) + ((current_base_row[22usize]) * (challenges[21usize])))
                    + ((current_base_row[23usize]) * (challenges[22usize]))));
        let node_1533 = ((current_base_row[22usize])
            + (BFieldElement::from_raw_u64(4294967295u64))) * (challenges[21usize]);
        let node_1573 = ((current_base_row[22usize])
            + (BFieldElement::from_raw_u64(8589934590u64))) * (challenges[21usize]);
        let node_2153 = (current_base_row[39usize]) * (challenges[22usize]);
        let node_2216 = (challenges[8usize])
            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                * (((node_1274) + ((current_base_row[22usize]) * (challenges[21usize])))
                    + (node_2153)));
        let node_2228 = (node_1274)
            + ((current_base_row[23usize]) * (challenges[21usize]));
        let node_2234 = (node_1274)
            + (((current_base_row[23usize])
                + (BFieldElement::from_raw_u64(4294967295u64))) * (challenges[21usize]));
        let node_2240 = (node_1274)
            + (((current_base_row[23usize])
                + (BFieldElement::from_raw_u64(8589934590u64))) * (challenges[21usize]));
        let node_2180 = (current_base_row[43usize]) * (challenges[22usize]);
        let base_constraints = [
            (next_base_row[0usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[0usize])
                        + (BFieldElement::from_raw_u64(4294967295u64)))),
            (current_base_row[6usize])
                * ((next_base_row[6usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_base_row[6usize]))),
            ((node_34) * (next_base_row[3usize]))
                + ((current_base_row[4usize])
                    * (((next_base_row[3usize]) + (node_30))
                        + (BFieldElement::from_raw_u64(18446744065119617026u64)))),
            (current_base_row[5usize])
                * ((next_base_row[5usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))),
            (((current_base_row[5usize])
                + (BFieldElement::from_raw_u64(18446744065119617026u64)))
                * (next_base_row[5usize]))
                * ((next_base_row[1usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))),
            (current_base_row[5usize]) * (next_base_row[1usize]),
            ((current_base_row[5usize]) * (node_34)) * (node_47),
            ((next_base_row[7usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (current_base_row[7usize])))
                + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            (current_base_row[8usize])
                * ((next_base_row[8usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_base_row[8usize]))),
            ((((((((((((((((((current_base_row[205usize]) * (node_120))
                + ((current_base_row[206usize]) * (node_545)))
                + ((current_base_row[213usize]) * (node_1235)))
                + ((current_base_row[223usize]) * (node_1242)))
                + ((current_base_row[218usize])
                    * ((((((current_base_row[195usize]) * (node_541))
                        + ((current_base_row[196usize])
                            * ((next_base_row[30usize]) + (node_540))))
                        + ((current_base_row[197usize])
                            * ((next_base_row[31usize]) + (node_540))))
                        + ((current_base_row[198usize])
                            * ((next_base_row[32usize]) + (node_540))))
                        + ((current_base_row[199usize])
                            * ((next_base_row[33usize]) + (node_540))))))
                + ((current_base_row[224usize])
                    * ((((((current_base_row[195usize]) * (node_1235))
                        + ((current_base_row[196usize])
                            * ((next_base_row[28usize]) + (node_544))))
                        + ((current_base_row[197usize]) * (node_1588)))
                        + ((current_base_row[198usize])
                            * ((next_base_row[28usize]) + (node_548))))
                        + ((current_base_row[199usize]) * (node_1662)))))
                + ((current_base_row[228usize]) * (node_1243)))
                + ((current_base_row[229usize]) * (node_1243)))
                + ((current_base_row[235usize]) * (node_1241)))
                + ((current_base_row[237usize]) * (node_120)))
                + ((current_base_row[234usize]) * (node_262)))
                + ((current_base_row[238usize]) * (node_262)))
                + ((current_base_row[243usize]) * (node_262)))
                + ((current_base_row[250usize]) * (node_262)))
                + ((current_base_row[268usize]) * (node_1182)))
                + ((current_base_row[269usize]) * (node_1182)))
                + ((current_base_row[282usize]) * (node_124))) * (node_3926),
            (node_4336) * (node_4335),
            ((node_4336)
                * ((next_base_row[49usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_base_row[49usize])))) * (next_base_row[47usize]),
            ((current_base_row[47usize])
                * ((current_base_row[47usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                * (node_4342),
            (((current_base_row[51usize])
                + (BFieldElement::from_raw_u64(18446744065119617026u64)))
                * (current_base_row[51usize])) * (node_4405),
            (current_base_row[54usize]) * (node_4413),
            (node_4410) * (node_4413),
            ((node_4413)
                * ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (next_base_row[51usize])))
                * ((next_base_row[53usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_base_row[53usize]))),
            (node_4413)
                * ((next_base_row[55usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_base_row[55usize]))),
            (node_4413)
                * ((next_base_row[56usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_base_row[56usize]))),
            (node_4517) * (node_4516),
            (node_4524)
                * ((next_base_row[60usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_base_row[60usize]))),
            (node_4524)
                * ((next_base_row[61usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_base_row[61usize]))),
            (current_base_row[368usize])
                * ((current_base_row[58usize])
                    + (BFieldElement::from_raw_u64(18446743927680663586u64))),
            ((current_base_row[363usize])
                * ((current_base_row[64usize])
                    + (BFieldElement::from_raw_u64(18446744052234715141u64))))
                * (next_base_row[64usize]),
            (((next_base_row[62usize]) * (node_5409)) * (node_5411))
                * (((next_base_row[64usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_base_row[64usize])))
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))),
            (current_base_row[369usize]) * (node_5439),
            (node_5441)
                * ((next_base_row[63usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_base_row[63usize]))),
            (node_5441)
                * ((next_base_row[62usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_base_row[62usize]))),
            ((current_base_row[364usize]) * (node_5435)) * (next_base_row[62usize]),
            (current_base_row[370usize]) * (next_base_row[62usize]),
            ((node_5455) * (node_5427)) * (next_base_row[62usize]),
            (next_base_row[64usize])
                * (((((((((((((((((((BFieldElement::from_raw_u64(263719581847590u64))
                    * (node_4646))
                    + ((BFieldElement::from_raw_u64(76643691379275u64)) * (node_4657)))
                    + ((BFieldElement::from_raw_u64(115096533571410u64)) * (node_4668)))
                    + ((BFieldElement::from_raw_u64(256362302871255u64)) * (node_4679)))
                    + ((BFieldElement::from_raw_u64(51629801853195u64))
                        * (current_base_row[306usize])))
                    + ((BFieldElement::from_raw_u64(175668457332795u64))
                        * (current_base_row[307usize])))
                    + ((BFieldElement::from_raw_u64(177601192615545u64))
                        * (current_base_row[308usize])))
                    + ((BFieldElement::from_raw_u64(118201794925695u64))
                        * (current_base_row[309usize])))
                    + ((BFieldElement::from_raw_u64(244602682417545u64))
                        * (current_base_row[310usize])))
                    + ((BFieldElement::from_raw_u64(51685636428030u64))
                        * (current_base_row[311usize])))
                    + ((BFieldElement::from_raw_u64(231348413345175u64))
                        * (current_base_row[312usize])))
                    + ((BFieldElement::from_raw_u64(185731565704980u64))
                        * (current_base_row[313usize])))
                    + ((BFieldElement::from_raw_u64(32014686216930u64))
                        * (current_base_row[314usize])))
                    + ((BFieldElement::from_raw_u64(145268678818785u64))
                        * (current_base_row[315usize])))
                    + ((BFieldElement::from_raw_u64(123480309731250u64))
                        * (current_base_row[316usize])))
                    + ((BFieldElement::from_raw_u64(4758823762860u64))
                        * (current_base_row[317usize]))) + (current_base_row[113usize]))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (node_5306))),
            (next_base_row[64usize])
                * (((((((((((((((((((BFieldElement::from_raw_u64(4758823762860u64))
                    * (node_4646))
                    + ((BFieldElement::from_raw_u64(263719581847590u64)) * (node_4657)))
                    + ((BFieldElement::from_raw_u64(76643691379275u64)) * (node_4668)))
                    + ((BFieldElement::from_raw_u64(115096533571410u64)) * (node_4679)))
                    + ((BFieldElement::from_raw_u64(256362302871255u64))
                        * (current_base_row[306usize])))
                    + ((BFieldElement::from_raw_u64(51629801853195u64))
                        * (current_base_row[307usize])))
                    + ((BFieldElement::from_raw_u64(175668457332795u64))
                        * (current_base_row[308usize])))
                    + ((BFieldElement::from_raw_u64(177601192615545u64))
                        * (current_base_row[309usize])))
                    + ((BFieldElement::from_raw_u64(118201794925695u64))
                        * (current_base_row[310usize])))
                    + ((BFieldElement::from_raw_u64(244602682417545u64))
                        * (current_base_row[311usize])))
                    + ((BFieldElement::from_raw_u64(51685636428030u64))
                        * (current_base_row[312usize])))
                    + ((BFieldElement::from_raw_u64(231348413345175u64))
                        * (current_base_row[313usize])))
                    + ((BFieldElement::from_raw_u64(185731565704980u64))
                        * (current_base_row[314usize])))
                    + ((BFieldElement::from_raw_u64(32014686216930u64))
                        * (current_base_row[315usize])))
                    + ((BFieldElement::from_raw_u64(145268678818785u64))
                        * (current_base_row[316usize])))
                    + ((BFieldElement::from_raw_u64(123480309731250u64))
                        * (current_base_row[317usize]))) + (current_base_row[114usize]))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (node_5317))),
            (next_base_row[64usize])
                * (((((((((((((((((((BFieldElement::from_raw_u64(123480309731250u64))
                    * (node_4646))
                    + ((BFieldElement::from_raw_u64(4758823762860u64)) * (node_4657)))
                    + ((BFieldElement::from_raw_u64(263719581847590u64)) * (node_4668)))
                    + ((BFieldElement::from_raw_u64(76643691379275u64)) * (node_4679)))
                    + ((BFieldElement::from_raw_u64(115096533571410u64))
                        * (current_base_row[306usize])))
                    + ((BFieldElement::from_raw_u64(256362302871255u64))
                        * (current_base_row[307usize])))
                    + ((BFieldElement::from_raw_u64(51629801853195u64))
                        * (current_base_row[308usize])))
                    + ((BFieldElement::from_raw_u64(175668457332795u64))
                        * (current_base_row[309usize])))
                    + ((BFieldElement::from_raw_u64(177601192615545u64))
                        * (current_base_row[310usize])))
                    + ((BFieldElement::from_raw_u64(118201794925695u64))
                        * (current_base_row[311usize])))
                    + ((BFieldElement::from_raw_u64(244602682417545u64))
                        * (current_base_row[312usize])))
                    + ((BFieldElement::from_raw_u64(51685636428030u64))
                        * (current_base_row[313usize])))
                    + ((BFieldElement::from_raw_u64(231348413345175u64))
                        * (current_base_row[314usize])))
                    + ((BFieldElement::from_raw_u64(185731565704980u64))
                        * (current_base_row[315usize])))
                    + ((BFieldElement::from_raw_u64(32014686216930u64))
                        * (current_base_row[316usize])))
                    + ((BFieldElement::from_raw_u64(145268678818785u64))
                        * (current_base_row[317usize]))) + (current_base_row[115usize]))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (node_5328))),
            (next_base_row[64usize])
                * (((((((((((((((((((BFieldElement::from_raw_u64(145268678818785u64))
                    * (node_4646))
                    + ((BFieldElement::from_raw_u64(123480309731250u64)) * (node_4657)))
                    + ((BFieldElement::from_raw_u64(4758823762860u64)) * (node_4668)))
                    + ((BFieldElement::from_raw_u64(263719581847590u64)) * (node_4679)))
                    + ((BFieldElement::from_raw_u64(76643691379275u64))
                        * (current_base_row[306usize])))
                    + ((BFieldElement::from_raw_u64(115096533571410u64))
                        * (current_base_row[307usize])))
                    + ((BFieldElement::from_raw_u64(256362302871255u64))
                        * (current_base_row[308usize])))
                    + ((BFieldElement::from_raw_u64(51629801853195u64))
                        * (current_base_row[309usize])))
                    + ((BFieldElement::from_raw_u64(175668457332795u64))
                        * (current_base_row[310usize])))
                    + ((BFieldElement::from_raw_u64(177601192615545u64))
                        * (current_base_row[311usize])))
                    + ((BFieldElement::from_raw_u64(118201794925695u64))
                        * (current_base_row[312usize])))
                    + ((BFieldElement::from_raw_u64(244602682417545u64))
                        * (current_base_row[313usize])))
                    + ((BFieldElement::from_raw_u64(51685636428030u64))
                        * (current_base_row[314usize])))
                    + ((BFieldElement::from_raw_u64(231348413345175u64))
                        * (current_base_row[315usize])))
                    + ((BFieldElement::from_raw_u64(185731565704980u64))
                        * (current_base_row[316usize])))
                    + ((BFieldElement::from_raw_u64(32014686216930u64))
                        * (current_base_row[317usize]))) + (current_base_row[116usize]))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (node_5339))),
            (next_base_row[64usize])
                * (((((((((((((((((((BFieldElement::from_raw_u64(32014686216930u64))
                    * (node_4646))
                    + ((BFieldElement::from_raw_u64(145268678818785u64)) * (node_4657)))
                    + ((BFieldElement::from_raw_u64(123480309731250u64)) * (node_4668)))
                    + ((BFieldElement::from_raw_u64(4758823762860u64)) * (node_4679)))
                    + ((BFieldElement::from_raw_u64(263719581847590u64))
                        * (current_base_row[306usize])))
                    + ((BFieldElement::from_raw_u64(76643691379275u64))
                        * (current_base_row[307usize])))
                    + ((BFieldElement::from_raw_u64(115096533571410u64))
                        * (current_base_row[308usize])))
                    + ((BFieldElement::from_raw_u64(256362302871255u64))
                        * (current_base_row[309usize])))
                    + ((BFieldElement::from_raw_u64(51629801853195u64))
                        * (current_base_row[310usize])))
                    + ((BFieldElement::from_raw_u64(175668457332795u64))
                        * (current_base_row[311usize])))
                    + ((BFieldElement::from_raw_u64(177601192615545u64))
                        * (current_base_row[312usize])))
                    + ((BFieldElement::from_raw_u64(118201794925695u64))
                        * (current_base_row[313usize])))
                    + ((BFieldElement::from_raw_u64(244602682417545u64))
                        * (current_base_row[314usize])))
                    + ((BFieldElement::from_raw_u64(51685636428030u64))
                        * (current_base_row[315usize])))
                    + ((BFieldElement::from_raw_u64(231348413345175u64))
                        * (current_base_row[316usize])))
                    + ((BFieldElement::from_raw_u64(185731565704980u64))
                        * (current_base_row[317usize]))) + (current_base_row[117usize]))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (next_base_row[97usize]))),
            (next_base_row[64usize])
                * (((((((((((((((((((BFieldElement::from_raw_u64(185731565704980u64))
                    * (node_4646))
                    + ((BFieldElement::from_raw_u64(32014686216930u64)) * (node_4657)))
                    + ((BFieldElement::from_raw_u64(145268678818785u64)) * (node_4668)))
                    + ((BFieldElement::from_raw_u64(123480309731250u64)) * (node_4679)))
                    + ((BFieldElement::from_raw_u64(4758823762860u64))
                        * (current_base_row[306usize])))
                    + ((BFieldElement::from_raw_u64(263719581847590u64))
                        * (current_base_row[307usize])))
                    + ((BFieldElement::from_raw_u64(76643691379275u64))
                        * (current_base_row[308usize])))
                    + ((BFieldElement::from_raw_u64(115096533571410u64))
                        * (current_base_row[309usize])))
                    + ((BFieldElement::from_raw_u64(256362302871255u64))
                        * (current_base_row[310usize])))
                    + ((BFieldElement::from_raw_u64(51629801853195u64))
                        * (current_base_row[311usize])))
                    + ((BFieldElement::from_raw_u64(175668457332795u64))
                        * (current_base_row[312usize])))
                    + ((BFieldElement::from_raw_u64(177601192615545u64))
                        * (current_base_row[313usize])))
                    + ((BFieldElement::from_raw_u64(118201794925695u64))
                        * (current_base_row[314usize])))
                    + ((BFieldElement::from_raw_u64(244602682417545u64))
                        * (current_base_row[315usize])))
                    + ((BFieldElement::from_raw_u64(51685636428030u64))
                        * (current_base_row[316usize])))
                    + ((BFieldElement::from_raw_u64(231348413345175u64))
                        * (current_base_row[317usize]))) + (current_base_row[118usize]))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (next_base_row[98usize]))),
            (next_base_row[64usize])
                * (((((((((((((((((((BFieldElement::from_raw_u64(231348413345175u64))
                    * (node_4646))
                    + ((BFieldElement::from_raw_u64(185731565704980u64)) * (node_4657)))
                    + ((BFieldElement::from_raw_u64(32014686216930u64)) * (node_4668)))
                    + ((BFieldElement::from_raw_u64(145268678818785u64)) * (node_4679)))
                    + ((BFieldElement::from_raw_u64(123480309731250u64))
                        * (current_base_row[306usize])))
                    + ((BFieldElement::from_raw_u64(4758823762860u64))
                        * (current_base_row[307usize])))
                    + ((BFieldElement::from_raw_u64(263719581847590u64))
                        * (current_base_row[308usize])))
                    + ((BFieldElement::from_raw_u64(76643691379275u64))
                        * (current_base_row[309usize])))
                    + ((BFieldElement::from_raw_u64(115096533571410u64))
                        * (current_base_row[310usize])))
                    + ((BFieldElement::from_raw_u64(256362302871255u64))
                        * (current_base_row[311usize])))
                    + ((BFieldElement::from_raw_u64(51629801853195u64))
                        * (current_base_row[312usize])))
                    + ((BFieldElement::from_raw_u64(175668457332795u64))
                        * (current_base_row[313usize])))
                    + ((BFieldElement::from_raw_u64(177601192615545u64))
                        * (current_base_row[314usize])))
                    + ((BFieldElement::from_raw_u64(118201794925695u64))
                        * (current_base_row[315usize])))
                    + ((BFieldElement::from_raw_u64(244602682417545u64))
                        * (current_base_row[316usize])))
                    + ((BFieldElement::from_raw_u64(51685636428030u64))
                        * (current_base_row[317usize]))) + (current_base_row[119usize]))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (next_base_row[99usize]))),
            (next_base_row[64usize])
                * (((((((((((((((((((BFieldElement::from_raw_u64(51685636428030u64))
                    * (node_4646))
                    + ((BFieldElement::from_raw_u64(231348413345175u64)) * (node_4657)))
                    + ((BFieldElement::from_raw_u64(185731565704980u64)) * (node_4668)))
                    + ((BFieldElement::from_raw_u64(32014686216930u64)) * (node_4679)))
                    + ((BFieldElement::from_raw_u64(145268678818785u64))
                        * (current_base_row[306usize])))
                    + ((BFieldElement::from_raw_u64(123480309731250u64))
                        * (current_base_row[307usize])))
                    + ((BFieldElement::from_raw_u64(4758823762860u64))
                        * (current_base_row[308usize])))
                    + ((BFieldElement::from_raw_u64(263719581847590u64))
                        * (current_base_row[309usize])))
                    + ((BFieldElement::from_raw_u64(76643691379275u64))
                        * (current_base_row[310usize])))
                    + ((BFieldElement::from_raw_u64(115096533571410u64))
                        * (current_base_row[311usize])))
                    + ((BFieldElement::from_raw_u64(256362302871255u64))
                        * (current_base_row[312usize])))
                    + ((BFieldElement::from_raw_u64(51629801853195u64))
                        * (current_base_row[313usize])))
                    + ((BFieldElement::from_raw_u64(175668457332795u64))
                        * (current_base_row[314usize])))
                    + ((BFieldElement::from_raw_u64(177601192615545u64))
                        * (current_base_row[315usize])))
                    + ((BFieldElement::from_raw_u64(118201794925695u64))
                        * (current_base_row[316usize])))
                    + ((BFieldElement::from_raw_u64(244602682417545u64))
                        * (current_base_row[317usize]))) + (current_base_row[120usize]))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (next_base_row[100usize]))),
            (next_base_row[64usize])
                * (((((((((((((((((((BFieldElement::from_raw_u64(244602682417545u64))
                    * (node_4646))
                    + ((BFieldElement::from_raw_u64(51685636428030u64)) * (node_4657)))
                    + ((BFieldElement::from_raw_u64(231348413345175u64)) * (node_4668)))
                    + ((BFieldElement::from_raw_u64(185731565704980u64)) * (node_4679)))
                    + ((BFieldElement::from_raw_u64(32014686216930u64))
                        * (current_base_row[306usize])))
                    + ((BFieldElement::from_raw_u64(145268678818785u64))
                        * (current_base_row[307usize])))
                    + ((BFieldElement::from_raw_u64(123480309731250u64))
                        * (current_base_row[308usize])))
                    + ((BFieldElement::from_raw_u64(4758823762860u64))
                        * (current_base_row[309usize])))
                    + ((BFieldElement::from_raw_u64(263719581847590u64))
                        * (current_base_row[310usize])))
                    + ((BFieldElement::from_raw_u64(76643691379275u64))
                        * (current_base_row[311usize])))
                    + ((BFieldElement::from_raw_u64(115096533571410u64))
                        * (current_base_row[312usize])))
                    + ((BFieldElement::from_raw_u64(256362302871255u64))
                        * (current_base_row[313usize])))
                    + ((BFieldElement::from_raw_u64(51629801853195u64))
                        * (current_base_row[314usize])))
                    + ((BFieldElement::from_raw_u64(175668457332795u64))
                        * (current_base_row[315usize])))
                    + ((BFieldElement::from_raw_u64(177601192615545u64))
                        * (current_base_row[316usize])))
                    + ((BFieldElement::from_raw_u64(118201794925695u64))
                        * (current_base_row[317usize]))) + (current_base_row[121usize]))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (next_base_row[101usize]))),
            (next_base_row[64usize])
                * (((((((((((((((((((BFieldElement::from_raw_u64(118201794925695u64))
                    * (node_4646))
                    + ((BFieldElement::from_raw_u64(244602682417545u64)) * (node_4657)))
                    + ((BFieldElement::from_raw_u64(51685636428030u64)) * (node_4668)))
                    + ((BFieldElement::from_raw_u64(231348413345175u64)) * (node_4679)))
                    + ((BFieldElement::from_raw_u64(185731565704980u64))
                        * (current_base_row[306usize])))
                    + ((BFieldElement::from_raw_u64(32014686216930u64))
                        * (current_base_row[307usize])))
                    + ((BFieldElement::from_raw_u64(145268678818785u64))
                        * (current_base_row[308usize])))
                    + ((BFieldElement::from_raw_u64(123480309731250u64))
                        * (current_base_row[309usize])))
                    + ((BFieldElement::from_raw_u64(4758823762860u64))
                        * (current_base_row[310usize])))
                    + ((BFieldElement::from_raw_u64(263719581847590u64))
                        * (current_base_row[311usize])))
                    + ((BFieldElement::from_raw_u64(76643691379275u64))
                        * (current_base_row[312usize])))
                    + ((BFieldElement::from_raw_u64(115096533571410u64))
                        * (current_base_row[313usize])))
                    + ((BFieldElement::from_raw_u64(256362302871255u64))
                        * (current_base_row[314usize])))
                    + ((BFieldElement::from_raw_u64(51629801853195u64))
                        * (current_base_row[315usize])))
                    + ((BFieldElement::from_raw_u64(175668457332795u64))
                        * (current_base_row[316usize])))
                    + ((BFieldElement::from_raw_u64(177601192615545u64))
                        * (current_base_row[317usize]))) + (current_base_row[122usize]))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (next_base_row[102usize]))),
            (next_base_row[64usize])
                * (((((((((((((((((((BFieldElement::from_raw_u64(177601192615545u64))
                    * (node_4646))
                    + ((BFieldElement::from_raw_u64(118201794925695u64)) * (node_4657)))
                    + ((BFieldElement::from_raw_u64(244602682417545u64)) * (node_4668)))
                    + ((BFieldElement::from_raw_u64(51685636428030u64)) * (node_4679)))
                    + ((BFieldElement::from_raw_u64(231348413345175u64))
                        * (current_base_row[306usize])))
                    + ((BFieldElement::from_raw_u64(185731565704980u64))
                        * (current_base_row[307usize])))
                    + ((BFieldElement::from_raw_u64(32014686216930u64))
                        * (current_base_row[308usize])))
                    + ((BFieldElement::from_raw_u64(145268678818785u64))
                        * (current_base_row[309usize])))
                    + ((BFieldElement::from_raw_u64(123480309731250u64))
                        * (current_base_row[310usize])))
                    + ((BFieldElement::from_raw_u64(4758823762860u64))
                        * (current_base_row[311usize])))
                    + ((BFieldElement::from_raw_u64(263719581847590u64))
                        * (current_base_row[312usize])))
                    + ((BFieldElement::from_raw_u64(76643691379275u64))
                        * (current_base_row[313usize])))
                    + ((BFieldElement::from_raw_u64(115096533571410u64))
                        * (current_base_row[314usize])))
                    + ((BFieldElement::from_raw_u64(256362302871255u64))
                        * (current_base_row[315usize])))
                    + ((BFieldElement::from_raw_u64(51629801853195u64))
                        * (current_base_row[316usize])))
                    + ((BFieldElement::from_raw_u64(175668457332795u64))
                        * (current_base_row[317usize]))) + (current_base_row[123usize]))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (next_base_row[103usize]))),
            (next_base_row[64usize])
                * (((((((((((((((((((BFieldElement::from_raw_u64(175668457332795u64))
                    * (node_4646))
                    + ((BFieldElement::from_raw_u64(177601192615545u64)) * (node_4657)))
                    + ((BFieldElement::from_raw_u64(118201794925695u64)) * (node_4668)))
                    + ((BFieldElement::from_raw_u64(244602682417545u64)) * (node_4679)))
                    + ((BFieldElement::from_raw_u64(51685636428030u64))
                        * (current_base_row[306usize])))
                    + ((BFieldElement::from_raw_u64(231348413345175u64))
                        * (current_base_row[307usize])))
                    + ((BFieldElement::from_raw_u64(185731565704980u64))
                        * (current_base_row[308usize])))
                    + ((BFieldElement::from_raw_u64(32014686216930u64))
                        * (current_base_row[309usize])))
                    + ((BFieldElement::from_raw_u64(145268678818785u64))
                        * (current_base_row[310usize])))
                    + ((BFieldElement::from_raw_u64(123480309731250u64))
                        * (current_base_row[311usize])))
                    + ((BFieldElement::from_raw_u64(4758823762860u64))
                        * (current_base_row[312usize])))
                    + ((BFieldElement::from_raw_u64(263719581847590u64))
                        * (current_base_row[313usize])))
                    + ((BFieldElement::from_raw_u64(76643691379275u64))
                        * (current_base_row[314usize])))
                    + ((BFieldElement::from_raw_u64(115096533571410u64))
                        * (current_base_row[315usize])))
                    + ((BFieldElement::from_raw_u64(256362302871255u64))
                        * (current_base_row[316usize])))
                    + ((BFieldElement::from_raw_u64(51629801853195u64))
                        * (current_base_row[317usize]))) + (current_base_row[124usize]))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (next_base_row[104usize]))),
            (next_base_row[64usize])
                * (((((((((((((((((((BFieldElement::from_raw_u64(51629801853195u64))
                    * (node_4646))
                    + ((BFieldElement::from_raw_u64(175668457332795u64)) * (node_4657)))
                    + ((BFieldElement::from_raw_u64(177601192615545u64)) * (node_4668)))
                    + ((BFieldElement::from_raw_u64(118201794925695u64)) * (node_4679)))
                    + ((BFieldElement::from_raw_u64(244602682417545u64))
                        * (current_base_row[306usize])))
                    + ((BFieldElement::from_raw_u64(51685636428030u64))
                        * (current_base_row[307usize])))
                    + ((BFieldElement::from_raw_u64(231348413345175u64))
                        * (current_base_row[308usize])))
                    + ((BFieldElement::from_raw_u64(185731565704980u64))
                        * (current_base_row[309usize])))
                    + ((BFieldElement::from_raw_u64(32014686216930u64))
                        * (current_base_row[310usize])))
                    + ((BFieldElement::from_raw_u64(145268678818785u64))
                        * (current_base_row[311usize])))
                    + ((BFieldElement::from_raw_u64(123480309731250u64))
                        * (current_base_row[312usize])))
                    + ((BFieldElement::from_raw_u64(4758823762860u64))
                        * (current_base_row[313usize])))
                    + ((BFieldElement::from_raw_u64(263719581847590u64))
                        * (current_base_row[314usize])))
                    + ((BFieldElement::from_raw_u64(76643691379275u64))
                        * (current_base_row[315usize])))
                    + ((BFieldElement::from_raw_u64(115096533571410u64))
                        * (current_base_row[316usize])))
                    + ((BFieldElement::from_raw_u64(256362302871255u64))
                        * (current_base_row[317usize]))) + (current_base_row[125usize]))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (next_base_row[105usize]))),
            (next_base_row[64usize])
                * (((((((((((((((((((BFieldElement::from_raw_u64(256362302871255u64))
                    * (node_4646))
                    + ((BFieldElement::from_raw_u64(51629801853195u64)) * (node_4657)))
                    + ((BFieldElement::from_raw_u64(175668457332795u64)) * (node_4668)))
                    + ((BFieldElement::from_raw_u64(177601192615545u64)) * (node_4679)))
                    + ((BFieldElement::from_raw_u64(118201794925695u64))
                        * (current_base_row[306usize])))
                    + ((BFieldElement::from_raw_u64(244602682417545u64))
                        * (current_base_row[307usize])))
                    + ((BFieldElement::from_raw_u64(51685636428030u64))
                        * (current_base_row[308usize])))
                    + ((BFieldElement::from_raw_u64(231348413345175u64))
                        * (current_base_row[309usize])))
                    + ((BFieldElement::from_raw_u64(185731565704980u64))
                        * (current_base_row[310usize])))
                    + ((BFieldElement::from_raw_u64(32014686216930u64))
                        * (current_base_row[311usize])))
                    + ((BFieldElement::from_raw_u64(145268678818785u64))
                        * (current_base_row[312usize])))
                    + ((BFieldElement::from_raw_u64(123480309731250u64))
                        * (current_base_row[313usize])))
                    + ((BFieldElement::from_raw_u64(4758823762860u64))
                        * (current_base_row[314usize])))
                    + ((BFieldElement::from_raw_u64(263719581847590u64))
                        * (current_base_row[315usize])))
                    + ((BFieldElement::from_raw_u64(76643691379275u64))
                        * (current_base_row[316usize])))
                    + ((BFieldElement::from_raw_u64(115096533571410u64))
                        * (current_base_row[317usize]))) + (current_base_row[126usize]))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (next_base_row[106usize]))),
            (next_base_row[64usize])
                * (((((((((((((((((((BFieldElement::from_raw_u64(115096533571410u64))
                    * (node_4646))
                    + ((BFieldElement::from_raw_u64(256362302871255u64)) * (node_4657)))
                    + ((BFieldElement::from_raw_u64(51629801853195u64)) * (node_4668)))
                    + ((BFieldElement::from_raw_u64(175668457332795u64)) * (node_4679)))
                    + ((BFieldElement::from_raw_u64(177601192615545u64))
                        * (current_base_row[306usize])))
                    + ((BFieldElement::from_raw_u64(118201794925695u64))
                        * (current_base_row[307usize])))
                    + ((BFieldElement::from_raw_u64(244602682417545u64))
                        * (current_base_row[308usize])))
                    + ((BFieldElement::from_raw_u64(51685636428030u64))
                        * (current_base_row[309usize])))
                    + ((BFieldElement::from_raw_u64(231348413345175u64))
                        * (current_base_row[310usize])))
                    + ((BFieldElement::from_raw_u64(185731565704980u64))
                        * (current_base_row[311usize])))
                    + ((BFieldElement::from_raw_u64(32014686216930u64))
                        * (current_base_row[312usize])))
                    + ((BFieldElement::from_raw_u64(145268678818785u64))
                        * (current_base_row[313usize])))
                    + ((BFieldElement::from_raw_u64(123480309731250u64))
                        * (current_base_row[314usize])))
                    + ((BFieldElement::from_raw_u64(4758823762860u64))
                        * (current_base_row[315usize])))
                    + ((BFieldElement::from_raw_u64(263719581847590u64))
                        * (current_base_row[316usize])))
                    + ((BFieldElement::from_raw_u64(76643691379275u64))
                        * (current_base_row[317usize]))) + (current_base_row[127usize]))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (next_base_row[107usize]))),
            (next_base_row[64usize])
                * (((((((((((((((((((BFieldElement::from_raw_u64(76643691379275u64))
                    * (node_4646))
                    + ((BFieldElement::from_raw_u64(115096533571410u64)) * (node_4657)))
                    + ((BFieldElement::from_raw_u64(256362302871255u64)) * (node_4668)))
                    + ((BFieldElement::from_raw_u64(51629801853195u64)) * (node_4679)))
                    + ((BFieldElement::from_raw_u64(175668457332795u64))
                        * (current_base_row[306usize])))
                    + ((BFieldElement::from_raw_u64(177601192615545u64))
                        * (current_base_row[307usize])))
                    + ((BFieldElement::from_raw_u64(118201794925695u64))
                        * (current_base_row[308usize])))
                    + ((BFieldElement::from_raw_u64(244602682417545u64))
                        * (current_base_row[309usize])))
                    + ((BFieldElement::from_raw_u64(51685636428030u64))
                        * (current_base_row[310usize])))
                    + ((BFieldElement::from_raw_u64(231348413345175u64))
                        * (current_base_row[311usize])))
                    + ((BFieldElement::from_raw_u64(185731565704980u64))
                        * (current_base_row[312usize])))
                    + ((BFieldElement::from_raw_u64(32014686216930u64))
                        * (current_base_row[313usize])))
                    + ((BFieldElement::from_raw_u64(145268678818785u64))
                        * (current_base_row[314usize])))
                    + ((BFieldElement::from_raw_u64(123480309731250u64))
                        * (current_base_row[315usize])))
                    + ((BFieldElement::from_raw_u64(4758823762860u64))
                        * (current_base_row[316usize])))
                    + ((BFieldElement::from_raw_u64(263719581847590u64))
                        * (current_base_row[317usize]))) + (current_base_row[128usize]))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (next_base_row[108usize]))),
            (current_base_row[129usize]) * (node_5946),
            (current_base_row[135usize]) * (node_5998),
            ((next_base_row[135usize]) * (next_base_row[136usize]))
                + ((node_5998)
                    * (((next_base_row[136usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (current_base_row[136usize])))
                        + (BFieldElement::from_raw_u64(18446744065119617026u64)))),
            ((next_base_row[139usize]) * (current_base_row[143usize])) * (node_6048),
            (next_base_row[139usize]) * (current_base_row[145usize]),
            (node_6058)
                * ((next_base_row[142usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_base_row[142usize]))),
            (((node_6058) * (current_base_row[143usize])) * (node_6048)) * (node_6066),
            ((node_6058) * (current_base_row[145usize])) * (node_6066),
            (((node_6058) * (node_6048)) * (node_6051)) * (node_6072),
            ((node_6058) * (node_6054)) * (node_6075),
            (((current_base_row[318usize]) * (node_6092)) * (node_6094))
                * (current_base_row[147usize]),
            ((node_6097) * (node_6094)) * (node_6099),
            (((current_base_row[324usize]) * (node_6072)) * (node_6054)) * (node_6099),
            (((current_base_row[324usize]) * (node_6051)) * (node_6075))
                * (current_base_row[147usize]),
            ((current_base_row[366usize])
                * ((current_base_row[139usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                * ((current_base_row[147usize])
                    + (BFieldElement::from_raw_u64(18446744060824649731u64))),
            ((current_base_row[366usize]) * (current_base_row[139usize]))
                * (current_base_row[147usize]),
            ((node_6058) * (current_base_row[365usize]))
                * (((current_base_row[147usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((BFieldElement::from_raw_u64(8589934590u64))
                            * (next_base_row[147usize]))))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((node_6051) * (node_6054)))),
            (current_base_row[373usize]) * ((current_base_row[147usize]) + (node_6064)),
            ((current_base_row[331usize]) * (next_base_row[143usize]))
                * ((next_base_row[147usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_base_row[147usize]))),
            (current_base_row[367usize])
                * ((next_base_row[143usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_base_row[143usize]))),
            ((current_base_row[367usize]) * (node_6075))
                * ((current_base_row[147usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (node_6158))),
            ((current_base_row[367usize]) * (node_6054))
                * ((current_base_row[147usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_base_row[374usize]))),
            ((node_6058) * ((current_base_row[329usize]) * (node_6085)))
                * (((current_base_row[147usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (next_base_row[147usize]))) + (node_6108)),
            (current_base_row[169usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_2330) * (current_base_row[13usize]))),
            (current_base_row[170usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[169usize]) * (node_2303))),
            (current_base_row[171usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_2330) * (node_2313))),
            (current_base_row[172usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[12usize]) * (node_2313)) * (node_2303))),
            (current_base_row[173usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_288) * (node_290))),
            (current_base_row[174usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[171usize]) * (node_2303))),
            (current_base_row[175usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_288) * (current_base_row[41usize]))),
            (current_base_row[176usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[170usize]) * (node_2305))),
            (current_base_row[177usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[172usize]) * (node_2305))),
            (current_base_row[178usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[170usize]) * (current_base_row[15usize]))),
            (current_base_row[179usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[173usize]) * (current_base_row[40usize]))),
            (current_base_row[180usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[172usize]) * (current_base_row[15usize]))),
            (current_base_row[181usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[175usize]) * (node_293))),
            (current_base_row[182usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[174usize]) * (node_2305))),
            (current_base_row[183usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[174usize]) * (current_base_row[15usize]))),
            (current_base_row[184usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[12usize]) * (current_base_row[13usize]))
                        * (node_2303))),
            (current_base_row[185usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[169usize]) * (current_base_row[14usize]))),
            (current_base_row[186usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[178usize]) * (node_2307))),
            (current_base_row[187usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[180usize]) * (node_2307))),
            (current_base_row[188usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[176usize]) * (node_2307))),
            (current_base_row[189usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[177usize]) * (node_2307))),
            (current_base_row[190usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[173usize]) * (node_293))),
            (current_base_row[191usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[171usize]) * (current_base_row[14usize]))),
            (current_base_row[192usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[182usize]) * (node_2307))),
            (current_base_row[193usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[177usize]) * (current_base_row[16usize]))),
            (current_base_row[194usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[176usize]) * (current_base_row[16usize]))),
            (current_base_row[195usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[190usize]) * (current_base_row[39usize]))),
            (current_base_row[196usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[179usize]) * (node_341))),
            (current_base_row[197usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[179usize]) * (current_base_row[39usize]))),
            (current_base_row[198usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[181usize]) * (node_341))),
            (current_base_row[199usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[181usize]) * (current_base_row[39usize]))),
            (current_base_row[200usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[188usize]) * (node_2309))),
            (current_base_row[201usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[183usize]) * (node_2307))),
            (current_base_row[202usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[178usize]) * (current_base_row[16usize]))),
            (current_base_row[203usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[186usize]) * (node_2309))),
            (current_base_row[204usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[184usize]) * (node_2305))),
            (current_base_row[205usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[189usize]) * (node_2309)) * (node_2311))),
            (current_base_row[206usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[193usize]) * (node_2309)) * (node_2311))),
            (current_base_row[207usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[42usize]) * (node_290))),
            (current_base_row[208usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[183usize]) * (current_base_row[16usize]))),
            (current_base_row[209usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[180usize]) * (current_base_row[16usize]))),
            (current_base_row[210usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[42usize]) * (current_base_row[41usize]))),
            (current_base_row[211usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[192usize]) * (node_2309))),
            (current_base_row[212usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[185usize]) * (node_2305))),
            (current_base_row[213usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[200usize]) * (node_2311))),
            (current_base_row[214usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[182usize]) * (current_base_row[16usize]))),
            (current_base_row[215usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[191usize]) * (node_2305))),
            (current_base_row[216usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[204usize]) * (node_2307)) * (node_2309))
                        * (node_2311))),
            (current_base_row[217usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[185usize]) * (current_base_row[15usize]))),
            (current_base_row[218usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[187usize]) * (current_base_row[17usize]))
                        * (node_2311))),
            (current_base_row[219usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[184usize]) * (current_base_row[15usize]))
                        * (node_2307)) * (node_2309))),
            (current_base_row[220usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[187usize]) * (node_2309)) * (node_2311))),
            (current_base_row[221usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[194usize]) * (node_2309))),
            (current_base_row[222usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[201usize]) * (node_2309))),
            (current_base_row[223usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[203usize]) * (node_2311))),
            (current_base_row[224usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[219usize]) * (node_2311))),
            (current_base_row[225usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[209usize]) * (node_2309)) * (node_2311))),
            (current_base_row[226usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[215usize]) * (node_2307))),
            (current_base_row[227usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[191usize]) * (current_base_row[15usize]))),
            (current_base_row[228usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[186usize]) * (current_base_row[17usize]))
                        * (node_2311))),
            (current_base_row[229usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[194usize]) * (current_base_row[17usize]))
                        * (node_2311))),
            (current_base_row[230usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[221usize]) * (node_2311))),
            (current_base_row[231usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[208usize]) * (node_2309))),
            (current_base_row[232usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[202usize]) * (node_2309)) * (node_2311))),
            (current_base_row[233usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[211usize]) * (node_2311))),
            (current_base_row[234usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[212usize]) * (node_2307)) * (node_2309))
                        * (node_2311))),
            (current_base_row[235usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[202usize]) * (current_base_row[17usize]))
                        * (node_2311))),
            (current_base_row[236usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[222usize]) * (node_2311))),
            (current_base_row[237usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[226usize]) * (node_2309)) * (node_2311))),
            (current_base_row[238usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[217usize]) * (node_2307)) * (node_2309))
                        * (node_2311))),
            (current_base_row[239usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[214usize]) * (node_2309))),
            (current_base_row[240usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[189usize]) * (current_base_row[17usize]))
                        * (node_2311))),
            (current_base_row[241usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[231usize]) * (node_2311))),
            (current_base_row[242usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[192usize]) * (current_base_row[17usize]))
                        * (node_2311))),
            (current_base_row[243usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[212usize]) * (current_base_row[16usize]))
                        * (node_2309)) * (node_2311))),
            (current_base_row[244usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[175usize]) * (current_base_row[40usize]))),
            (current_base_row[245usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[207usize]) * (node_293))),
            (current_base_row[246usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[207usize]) * (current_base_row[40usize]))),
            (current_base_row[247usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[210usize]) * (node_293))),
            (current_base_row[248usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[210usize]) * (current_base_row[40usize]))),
            (current_base_row[249usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[41usize])
                        * ((current_base_row[41usize])
                            + (BFieldElement::from_raw_u64(18446744065119617026u64))))),
            (current_base_row[250usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[217usize]) * (current_base_row[16usize]))
                        * (node_2309)) * (node_2311))),
            (current_base_row[251usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[97usize]) * (current_base_row[97usize]))
                        * (current_base_row[97usize])) * (current_base_row[97usize]))),
            (current_base_row[252usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[227usize]) * (node_2307))),
            (current_base_row[253usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[98usize]) * (current_base_row[98usize]))
                        * (current_base_row[98usize])) * (current_base_row[98usize]))),
            (current_base_row[254usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[42usize])
                        * ((current_base_row[42usize])
                            + (BFieldElement::from_raw_u64(18446744065119617026u64))))),
            (current_base_row[255usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[99usize]) * (current_base_row[99usize]))
                        * (current_base_row[99usize])) * (current_base_row[99usize]))),
            (current_base_row[256usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[100usize]) * (current_base_row[100usize]))
                        * (current_base_row[100usize])) * (current_base_row[100usize]))),
            (current_base_row[257usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[201usize]) * (current_base_row[17usize]))
                        * (node_2311))),
            (current_base_row[258usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[188usize]) * (current_base_row[17usize]))
                        * (node_2311))),
            (current_base_row[259usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[101usize]) * (current_base_row[101usize]))
                        * (current_base_row[101usize])) * (current_base_row[101usize]))),
            (current_base_row[260usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[214usize]) * (current_base_row[17usize]))
                        * (node_2311))),
            (current_base_row[261usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[193usize]) * (current_base_row[17usize]))
                        * (node_2311))),
            (current_base_row[262usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[208usize]) * (current_base_row[17usize]))
                        * (node_2311))),
            (current_base_row[263usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[211usize]) * (current_base_row[18usize]))),
            (current_base_row[264usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[102usize]) * (current_base_row[102usize]))
                        * (current_base_row[102usize])) * (current_base_row[102usize]))),
            (current_base_row[265usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[239usize]) * (node_2311))),
            (current_base_row[266usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[215usize]) * (current_base_row[16usize]))
                        * (node_2309)) * (node_2311))),
            (current_base_row[267usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[103usize]) * (current_base_row[103usize]))
                        * (current_base_row[103usize])) * (current_base_row[103usize]))),
            (current_base_row[268usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[200usize]) * (current_base_row[18usize]))),
            (current_base_row[269usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[203usize]) * (current_base_row[18usize]))),
            (current_base_row[270usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[252usize]) * (node_2309)) * (node_2311))),
            (current_base_row[271usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[39usize]) * (node_1252))),
            (current_base_row[272usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[104usize]) * (current_base_row[104usize]))
                        * (current_base_row[104usize])) * (current_base_row[104usize]))),
            (current_base_row[273usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[227usize]) * (current_base_row[16usize]))
                        * (node_2309)) * (node_2311))),
            (current_base_row[274usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[105usize]) * (current_base_row[105usize]))
                        * (current_base_row[105usize])) * (current_base_row[105usize]))),
            (current_base_row[275usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[209usize]) * (current_base_row[17usize]))
                        * (node_2311))),
            (current_base_row[276usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[204usize]) * (current_base_row[16usize]))
                        * (node_2309)) * (node_2311))),
            (current_base_row[277usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[106usize]) * (current_base_row[106usize]))
                        * (current_base_row[106usize])) * (current_base_row[106usize]))),
            (current_base_row[278usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[107usize]) * (current_base_row[107usize]))
                        * (current_base_row[107usize])) * (current_base_row[107usize]))),
            (current_base_row[279usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[39usize]) * (current_base_row[22usize]))),
            (current_base_row[280usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[108usize]) * (current_base_row[108usize]))
                        * (current_base_row[108usize])) * (current_base_row[108usize]))),
            (current_base_row[281usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[222usize]) * (current_base_row[18usize]))),
            (current_base_row[282usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[221usize]) * (current_base_row[18usize]))),
            (current_base_row[283usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[190usize]) * (node_341))),
            (current_base_row[284usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[244usize]) * (node_341))),
            (current_base_row[285usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[244usize]) * (current_base_row[39usize]))),
            (current_base_row[286usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[245usize]) * (node_341))),
            (current_base_row[287usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[245usize]) * (current_base_row[39usize]))),
            (current_base_row[288usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[246usize]) * (node_341))),
            (current_base_row[289usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[246usize]) * (current_base_row[39usize]))),
            (current_base_row[290usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[247usize]) * (node_341))),
            (current_base_row[291usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[247usize]) * (current_base_row[39usize]))),
            (current_base_row[292usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[248usize]) * (node_341))),
            (current_base_row[293usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[248usize]) * (current_base_row[39usize]))),
            (current_base_row[294usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((next_base_row[64usize]) * (node_5484)) * (node_5485))
                        * (node_5487))),
            (current_base_row[295usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[44usize])
                        * ((current_base_row[44usize])
                            + (BFieldElement::from_raw_u64(18446744065119617026u64))))),
            (current_base_row[296usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((next_base_row[62usize]) * (node_5491)) * (node_5439))),
            (current_base_row[297usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[252usize]) * (current_base_row[17usize]))
                        * (node_2311))),
            (current_base_row[298usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[226usize]) * (current_base_row[17usize]))
                        * (node_2311))),
            (current_base_row[299usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[43usize])
                        * ((current_base_row[43usize])
                            + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                        * ((current_base_row[43usize])
                            + (BFieldElement::from_raw_u64(18446744060824649731u64))))
                        * ((current_base_row[43usize])
                            + (BFieldElement::from_raw_u64(18446744056529682436u64))))),
            (current_base_row[300usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[239usize]) * (current_base_row[18usize]))),
            (current_base_row[301usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[231usize]) * (current_base_row[18usize]))),
            (current_base_row[302usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((node_6077) * (node_6079)) * (node_6083)) * (node_6085))),
            (current_base_row[303usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[40usize]) * (node_133))),
            (current_base_row[304usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_6077)
                        * ((next_base_row[142usize])
                            + (BFieldElement::from_raw_u64(18446744043644780551u64))))),
            (current_base_row[305usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((node_5484) * (node_5485)) * (node_5487)) * (node_5489))),
            (current_base_row[306usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[251usize]) * (current_base_row[97usize]))
                        * (current_base_row[97usize])) * (current_base_row[97usize]))),
            (current_base_row[307usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[253usize]) * (current_base_row[98usize]))
                        * (current_base_row[98usize])) * (current_base_row[98usize]))),
            (current_base_row[308usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[255usize]) * (current_base_row[99usize]))
                        * (current_base_row[99usize])) * (current_base_row[99usize]))),
            (current_base_row[309usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[256usize]) * (current_base_row[100usize]))
                        * (current_base_row[100usize])) * (current_base_row[100usize]))),
            (current_base_row[310usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[259usize]) * (current_base_row[101usize]))
                        * (current_base_row[101usize])) * (current_base_row[101usize]))),
            (current_base_row[311usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[264usize]) * (current_base_row[102usize]))
                        * (current_base_row[102usize])) * (current_base_row[102usize]))),
            (current_base_row[312usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[267usize]) * (current_base_row[103usize]))
                        * (current_base_row[103usize])) * (current_base_row[103usize]))),
            (current_base_row[313usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[272usize]) * (current_base_row[104usize]))
                        * (current_base_row[104usize])) * (current_base_row[104usize]))),
            (current_base_row[314usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[274usize]) * (current_base_row[105usize]))
                        * (current_base_row[105usize])) * (current_base_row[105usize]))),
            (current_base_row[315usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[277usize]) * (current_base_row[106usize]))
                        * (current_base_row[106usize])) * (current_base_row[106usize]))),
            (current_base_row[316usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[278usize]) * (current_base_row[107usize]))
                        * (current_base_row[107usize])) * (current_base_row[107usize]))),
            (current_base_row[317usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[280usize]) * (current_base_row[108usize]))
                        * (current_base_row[108usize])) * (current_base_row[108usize]))),
            (current_base_row[318usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_6058) * ((current_base_row[302usize]) * (node_6089)))),
            (current_base_row[319usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[304usize]) * (node_6079))),
            (current_base_row[320usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[305usize]) * (node_5491))),
            (current_base_row[321usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((node_4039)
                        * ((next_base_row[13usize])
                            + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                        * (next_base_row[14usize]))),
            (current_base_row[322usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[39usize]) * (node_1915))),
            (current_base_row[323usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[39usize])
                        * ((current_base_row[39usize])
                            + (BFieldElement::from_raw_u64(18446744065119617026u64))))),
            (current_base_row[324usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_6097) * (node_6092))),
            (current_base_row[325usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((node_4039) * (next_base_row[13usize]))
                        * ((next_base_row[14usize])
                            + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                        * (node_4043))),
            (current_base_row[326usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((node_5430) * (node_5451)) * (next_base_row[62usize]))),
            (current_base_row[327usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[24usize]) * (current_base_row[27usize]))),
            (current_base_row[328usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[24usize]) * (next_base_row[24usize]))),
            (current_base_row[329usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[319usize]) * (node_6083))),
            (current_base_row[330usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((((current_base_row[10usize])
                        + (BFieldElement::from_raw_u64(18446743897615892521u64)))
                        * ((current_base_row[10usize])
                            + (BFieldElement::from_raw_u64(18446743923385696291u64))))
                        * ((current_base_row[10usize])
                            + (BFieldElement::from_raw_u64(18446743863256154161u64))))
                        * ((current_base_row[10usize])
                            + (BFieldElement::from_raw_u64(18446743828896415801u64))))),
            (current_base_row[331usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_6058)
                        * (((current_base_row[319usize]) * (node_6085)) * (node_6089)))),
            (current_base_row[332usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_4075) * (next_base_row[22usize]))),
            (current_base_row[333usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((next_base_row[44usize]) * (next_base_row[39usize]))),
            (current_base_row[334usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_4075) * (next_base_row[23usize]))),
            (current_base_row[335usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((next_base_row[44usize]) * (next_base_row[40usize]))),
            (current_base_row[336usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_4075) * (next_base_row[24usize]))),
            (current_base_row[337usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((next_base_row[44usize]) * (next_base_row[41usize]))),
            (current_base_row[338usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_4075) * (next_base_row[25usize]))),
            (current_base_row[339usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((next_base_row[44usize]) * (next_base_row[42usize]))),
            (current_base_row[340usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_4075) * (next_base_row[26usize]))),
            (current_base_row[341usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((next_base_row[44usize]) * (next_base_row[43usize]))),
            (current_base_row[342usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_4075) * (next_base_row[39usize]))),
            (current_base_row[343usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((next_base_row[44usize]) * (next_base_row[22usize]))),
            (current_base_row[344usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_4075) * (next_base_row[40usize]))),
            (current_base_row[345usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((next_base_row[44usize]) * (next_base_row[23usize]))),
            (current_base_row[346usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_4075) * (next_base_row[41usize]))),
            (current_base_row[347usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((next_base_row[44usize]) * (next_base_row[24usize]))),
            (current_base_row[348usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_4075) * (next_base_row[42usize]))),
            (current_base_row[349usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((next_base_row[44usize]) * (next_base_row[25usize]))),
            (current_base_row[350usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_4075) * (next_base_row[43usize]))),
            (current_base_row[351usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((next_base_row[44usize]) * (next_base_row[26usize]))),
            (current_base_row[352usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[325usize]) * (next_base_row[16usize]))
                        * ((next_base_row[17usize])
                            + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                        * (node_4048))),
            (current_base_row[353usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[321usize]) * (node_4043)) * (node_4054))
                        * (next_base_row[17usize]))),
            (current_base_row[354usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[39usize]) * (current_base_row[42usize]))),
            (current_base_row[355usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[321usize]) * (next_base_row[15usize]))
                        * (node_4054)) * (next_base_row[17usize]))),
            (current_base_row[356usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[320usize])
                        * (((node_5451) * (node_5435)) * (next_base_row[62usize])))),
            (current_base_row[357usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((node_5426) * (node_5427)) * (current_base_row[62usize]))),
            (current_base_row[358usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[237usize])
                        * ((next_base_row[22usize])
                            * (((current_base_row[39usize])
                                * ((next_base_row[23usize])
                                    + (BFieldElement::from_raw_u64(4294967296u64))))
                                + (BFieldElement::from_raw_u64(
                                    18446744065119617026u64,
                                )))))),
            (current_base_row[359usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[213usize])
                        * ((((node_1182) * (current_base_row[22usize]))
                            + (((node_116) * (node_1184)) * (node_133)))
                            + ((((node_113)
                                + (BFieldElement::from_raw_u64(18446744056529682436u64)))
                                * (node_1184)) * (current_base_row[40usize]))))),
            (current_base_row[360usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[213usize])
                        * (((current_base_row[249usize])
                            * ((current_base_row[41usize])
                                + (BFieldElement::from_raw_u64(18446744060824649731u64))))
                            * ((current_base_row[41usize])
                                + (BFieldElement::from_raw_u64(
                                    18446744056529682436u64,
                                )))))),
            (current_base_row[361usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[213usize])
                        * (((current_base_row[254usize])
                            * ((current_base_row[42usize])
                                + (BFieldElement::from_raw_u64(18446744060824649731u64))))
                            * ((current_base_row[42usize])
                                + (BFieldElement::from_raw_u64(
                                    18446744056529682436u64,
                                )))))),
            (current_base_row[362usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[213usize])
                        * (((current_base_row[295usize])
                            * ((current_base_row[44usize])
                                + (BFieldElement::from_raw_u64(18446744060824649731u64))))
                            * ((current_base_row[44usize])
                                + (BFieldElement::from_raw_u64(
                                    18446744056529682436u64,
                                )))))),
            (current_base_row[363usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[64usize])
                        * ((current_base_row[64usize])
                            + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                        * ((current_base_row[64usize])
                            + (BFieldElement::from_raw_u64(18446744060824649731u64))))
                        * ((current_base_row[64usize])
                            + (BFieldElement::from_raw_u64(18446744056529682436u64))))),
            (current_base_row[364usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((node_5448) * (node_5427)) * (current_base_row[62usize]))
                        * (node_5451))),
            (current_base_row[365usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[304usize]) * (node_6083)) * (node_6085))
                        * (node_6089))),
            (current_base_row[366usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[324usize])
                        * ((((BFieldElement::from_raw_u64(4294967295u64)) + (node_6108))
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (node_6054)))
                            + (((BFieldElement::from_raw_u64(8589934590u64))
                                * (node_6051)) * (node_6054))))),
            (current_base_row[367usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_6058) * ((current_base_row[329usize]) * (node_6089)))),
            (current_base_row[368usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_4524)
                        * ((node_4532)
                            + (BFieldElement::from_raw_u64(18446744065119617026u64))))),
            (current_base_row[369usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[357usize])
                        * (((node_5430) * (node_5435)) * (next_base_row[62usize])))),
            (current_base_row[370usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((node_5455) * (current_base_row[62usize])) * (node_5435))),
            (current_base_row[371usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_base_row[320usize]) * (node_5435))
                        * (next_base_row[62usize])) * (node_5439))),
            (current_base_row[372usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[320usize])
                        * (((node_5542) * (node_5439)) * (node_5544)))),
            (current_base_row[373usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((current_base_row[331usize])
                        * ((BFieldElement::from_raw_u64(4294967295u64))
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * ((next_base_row[143usize]) * (next_base_row[144usize])))))
                        * (current_base_row[143usize]))),
            (current_base_row[374usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_6158) * (current_base_row[143usize]))),
        ];
        let ext_constraints = [
            (((BFieldElement::from_raw_u64(4294967295u64))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (current_base_row[5usize])))
                * (((node_51)
                    * ((challenges[3usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * ((((challenges[13usize]) * (current_base_row[0usize]))
                                + ((challenges[14usize]) * (current_base_row[1usize])))
                                + ((challenges[15usize]) * (next_base_row[1usize]))))))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_base_row[2usize]))))
                + ((current_base_row[5usize]) * (node_51)),
            ((node_31)
                * (((next_ext_row[1usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((challenges[29usize]) * (current_ext_row[1usize]))))
                    + (node_74)))
                + ((node_34)
                    * (((next_ext_row[1usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (challenges[29usize]))) + (node_74))),
            ((((((next_ext_row[2usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((challenges[30usize]) * (current_ext_row[2usize]))))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (next_ext_row[1usize]))) * (node_47))
                * ((BFieldElement::from_raw_u64(4294967295u64))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((next_base_row[4usize]) * (node_90)))))
                + ((node_88) * (next_base_row[6usize]))) + ((node_88) * (node_90)),
            ((((((((((((((((((((((((((((((((((((((((((((((current_base_row[216usize])
                * (node_120))
                + ((current_base_row[205usize])
                    * ((next_base_row[22usize]) + (node_525))))
                + ((current_base_row[220usize]) * (node_120)))
                + ((current_base_row[206usize])
                    * (((((((((((((((((current_base_row[283usize]) * (node_810))
                        + ((current_base_row[195usize]) * (node_812)))
                        + ((current_base_row[196usize])
                            * ((next_base_row[22usize]) + (node_532))))
                        + ((current_base_row[197usize])
                            * ((next_base_row[22usize]) + (node_534))))
                        + ((current_base_row[198usize])
                            * ((next_base_row[22usize]) + (node_536))))
                        + ((current_base_row[199usize])
                            * ((next_base_row[22usize]) + (node_538))))
                        + ((current_base_row[284usize])
                            * ((next_base_row[22usize]) + (node_540))))
                        + ((current_base_row[285usize])
                            * ((next_base_row[22usize]) + (node_542))))
                        + ((current_base_row[286usize])
                            * ((next_base_row[22usize]) + (node_544))))
                        + ((current_base_row[287usize])
                            * ((next_base_row[22usize]) + (node_546))))
                        + ((current_base_row[288usize])
                            * ((next_base_row[22usize]) + (node_548))))
                        + ((current_base_row[289usize])
                            * ((next_base_row[22usize]) + (node_550))))
                        + ((current_base_row[290usize])
                            * ((next_base_row[22usize]) + (node_552))))
                        + ((current_base_row[291usize])
                            * ((next_base_row[22usize]) + (node_554))))
                        + ((current_base_row[292usize])
                            * ((next_base_row[22usize]) + (node_556))))
                        + ((current_base_row[293usize])
                            * ((next_base_row[22usize]) + (node_854))))))
                + ((current_base_row[225usize])
                    * (((((((((((((((((current_base_row[283usize]) * (node_864))
                        + ((current_base_row[195usize])
                            * ((node_860)
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * ((((((((((((((((node_229)
                                        + ((challenges[33usize]) * (current_base_row[22usize])))
                                        + (node_600)) + (node_602)) + (node_604)) + (node_606))
                                        + (node_608)) + (node_610)) + (node_612)) + (node_614))
                                        + (node_616)) + (node_618)) + (node_620)) + (node_622))
                                        + (node_624)) + (node_861))))))
                        + ((current_base_row[196usize])
                            * ((node_860)
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * ((((((((((((((((node_299) + (node_598))
                                        + ((challenges[34usize]) * (current_base_row[22usize])))
                                        + (node_602)) + (node_604)) + (node_606)) + (node_608))
                                        + (node_610)) + (node_612)) + (node_614)) + (node_616))
                                        + (node_618)) + (node_620)) + (node_622)) + (node_624))
                                        + (node_861))))))
                        + ((current_base_row[197usize])
                            * ((node_860)
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * ((((((((((((((((node_346) + (node_598)) + (node_600))
                                        + ((challenges[35usize]) * (current_base_row[22usize])))
                                        + (node_604)) + (node_606)) + (node_608)) + (node_610))
                                        + (node_612)) + (node_614)) + (node_616)) + (node_618))
                                        + (node_620)) + (node_622)) + (node_624)) + (node_861))))))
                        + ((current_base_row[198usize])
                            * ((node_860)
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * ((((((((((((((((node_390) + (node_598)) + (node_600))
                                        + (node_602))
                                        + ((challenges[36usize]) * (current_base_row[22usize])))
                                        + (node_606)) + (node_608)) + (node_610)) + (node_612))
                                        + (node_614)) + (node_616)) + (node_618)) + (node_620))
                                        + (node_622)) + (node_624)) + (node_861))))))
                        + ((current_base_row[199usize])
                            * ((node_860)
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * ((((((((((((((((node_433) + (node_598)) + (node_600))
                                        + (node_602)) + (node_604))
                                        + ((challenges[37usize]) * (current_base_row[22usize])))
                                        + (node_608)) + (node_610)) + (node_612)) + (node_614))
                                        + (node_616)) + (node_618)) + (node_620)) + (node_622))
                                        + (node_624)) + (node_861))))))
                        + ((current_base_row[284usize])
                            * ((node_860)
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (((((((((((((((((challenges[32usize])
                                        * (current_base_row[28usize])) + (node_598)) + (node_600))
                                        + (node_602)) + (node_604)) + (node_606))
                                        + ((challenges[38usize]) * (current_base_row[22usize])))
                                        + (node_610)) + (node_612)) + (node_614)) + (node_616))
                                        + (node_618)) + (node_620)) + (node_622)) + (node_624))
                                        + (node_861))))))
                        + ((current_base_row[285usize])
                            * ((node_860)
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (((((((((((((((((challenges[32usize])
                                        * (current_base_row[29usize])) + (node_598)) + (node_600))
                                        + (node_602)) + (node_604)) + (node_606)) + (node_608))
                                        + ((challenges[39usize]) * (current_base_row[22usize])))
                                        + (node_612)) + (node_614)) + (node_616)) + (node_618))
                                        + (node_620)) + (node_622)) + (node_624)) + (node_861))))))
                        + ((current_base_row[286usize])
                            * ((node_860)
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (((((((((((((((((challenges[32usize])
                                        * (current_base_row[30usize])) + (node_598)) + (node_600))
                                        + (node_602)) + (node_604)) + (node_606)) + (node_608))
                                        + (node_610))
                                        + ((challenges[40usize]) * (current_base_row[22usize])))
                                        + (node_614)) + (node_616)) + (node_618)) + (node_620))
                                        + (node_622)) + (node_624)) + (node_861))))))
                        + ((current_base_row[287usize])
                            * ((node_860)
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (((((((((((((((((challenges[32usize])
                                        * (current_base_row[31usize])) + (node_598)) + (node_600))
                                        + (node_602)) + (node_604)) + (node_606)) + (node_608))
                                        + (node_610)) + (node_612))
                                        + ((challenges[41usize]) * (current_base_row[22usize])))
                                        + (node_616)) + (node_618)) + (node_620)) + (node_622))
                                        + (node_624)) + (node_861))))))
                        + ((current_base_row[288usize])
                            * ((node_860)
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * ((((((((((((((((node_1050) + (node_598)) + (node_600))
                                        + (node_602)) + (node_604)) + (node_606)) + (node_608))
                                        + (node_610)) + (node_612)) + (node_614))
                                        + ((challenges[42usize]) * (current_base_row[22usize])))
                                        + (node_618)) + (node_620)) + (node_622)) + (node_624))
                                        + (node_861))))))
                        + ((current_base_row[289usize])
                            * ((node_860)
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (((((((((((((((((challenges[32usize])
                                        * (current_base_row[33usize])) + (node_598)) + (node_600))
                                        + (node_602)) + (node_604)) + (node_606)) + (node_608))
                                        + (node_610)) + (node_612)) + (node_614)) + (node_616))
                                        + ((challenges[43usize]) * (current_base_row[22usize])))
                                        + (node_620)) + (node_622)) + (node_624)) + (node_861))))))
                        + ((current_base_row[290usize])
                            * ((node_860)
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (((((((((((((((((challenges[32usize])
                                        * (current_base_row[34usize])) + (node_598)) + (node_600))
                                        + (node_602)) + (node_604)) + (node_606)) + (node_608))
                                        + (node_610)) + (node_612)) + (node_614)) + (node_616))
                                        + (node_618))
                                        + ((challenges[44usize]) * (current_base_row[22usize])))
                                        + (node_622)) + (node_624)) + (node_861))))))
                        + ((current_base_row[291usize])
                            * ((node_860)
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (((((((((((((((((challenges[32usize])
                                        * (current_base_row[35usize])) + (node_598)) + (node_600))
                                        + (node_602)) + (node_604)) + (node_606)) + (node_608))
                                        + (node_610)) + (node_612)) + (node_614)) + (node_616))
                                        + (node_618)) + (node_620))
                                        + ((challenges[45usize]) * (current_base_row[22usize])))
                                        + (node_624)) + (node_861))))))
                        + ((current_base_row[292usize])
                            * ((node_860)
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (((((((((((((((((challenges[32usize])
                                        * (current_base_row[36usize])) + (node_598)) + (node_600))
                                        + (node_602)) + (node_604)) + (node_606)) + (node_608))
                                        + (node_610)) + (node_612)) + (node_614)) + (node_616))
                                        + (node_618)) + (node_620)) + (node_622))
                                        + ((challenges[46usize]) * (current_base_row[22usize])))
                                        + (node_861))))))
                        + ((current_base_row[293usize])
                            * ((node_860)
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (((((((((((((((((challenges[32usize])
                                        * (current_base_row[37usize])) + (node_598)) + (node_600))
                                        + (node_602)) + (node_604)) + (node_606)) + (node_608))
                                        + (node_610)) + (node_612)) + (node_614)) + (node_616))
                                        + (node_618)) + (node_620)) + (node_622)) + (node_624))
                                        + ((challenges[47usize])
                                            * (current_base_row[22usize])))))))))
                + ((current_base_row[233usize]) * (node_1181)))
                + ((current_base_row[236usize]) * (node_120)))
                + ((current_base_row[213usize])
                    * ((node_1184) * (current_base_row[39usize]))))
                + ((current_base_row[240usize])
                    * ((node_120)
                        + (BFieldElement::from_raw_u64(18446744065119617026u64)))))
                + ((current_base_row[265usize]) * (node_1249)))
                + ((current_base_row[241usize]) * (node_1251)))
                + ((current_base_row[242usize])
                    * (((node_1255) * (current_base_row[39usize]))
                        + ((current_base_row[271usize]) * (node_124)))))
                + ((current_base_row[223usize])
                    * ((current_base_row[22usize])
                        + (BFieldElement::from_raw_u64(18446744065119617026u64)))))
                + ((current_base_row[218usize]) * (node_120)))
                + ((current_base_row[224usize]) * (node_120)))
                + ((current_base_row[230usize]) * (node_120)))
                + ((current_base_row[232usize])
                    * ((current_base_row[27usize]) + (node_528))))
                + ((current_base_row[257usize]) * (node_120)))
                + ((current_base_row[258usize]) * (node_120)))
                + ((current_base_row[260usize])
                    * ((node_810)
                        + (BFieldElement::from_raw_u64(18446744026464911371u64)))))
                + ((current_base_row[262usize]) * (node_120)))
                + ((current_base_row[228usize]) * ((node_810) + (node_530))))
                + ((current_base_row[261usize]) * ((node_810) + (node_525))))
                + ((current_base_row[229usize]) * (node_1912)))
                + ((current_base_row[263usize])
                    * ((node_1913)
                        + (BFieldElement::from_raw_u64(18446744065119617026u64)))))
                + ((current_base_row[235usize])
                    * ((current_base_row[39usize]) * (node_1918))))
                + ((current_base_row[237usize])
                    * ((current_base_row[22usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((BFieldElement::from_raw_u64(18446744069414584320u64))
                                * (next_base_row[23usize])) + (next_base_row[22usize]))))))
                + ((current_base_row[234usize]) * (node_120)))
                + ((current_base_row[238usize]) * (node_120)))
                + ((current_base_row[243usize]) * (node_120)))
                + ((current_base_row[270usize]) * (node_120)))
                + ((current_base_row[250usize]) * (node_120)))
                + ((current_base_row[266usize])
                    * (((current_base_row[22usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (node_1934))) + (node_1937))))
                + ((current_base_row[273usize]) * (node_120)))
                + ((current_base_row[268usize]) * ((node_810) + (node_534))))
                + ((current_base_row[269usize])
                    * ((next_base_row[22usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * ((node_1972)
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (node_1983)))))))
                + ((current_base_row[281usize])
                    * ((((node_1913)
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (node_1997)))
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (node_2000)))
                        + (BFieldElement::from_raw_u64(18446744065119617026u64)))))
                + ((current_base_row[282usize]) * (node_1912)))
                + ((current_base_row[275usize]) * (node_120)))
                + ((current_base_row[276usize]) * (node_120)))
                + ((current_base_row[298usize]) * (current_base_row[295usize])))
                + ((current_base_row[297usize])
                    * (((challenges[38usize]) * ((next_base_row[28usize]) + (node_540)))
                        + ((challenges[39usize])
                            * (((next_base_row[29usize]) + (node_542))
                                + (BFieldElement::from_raw_u64(
                                    18446744047939747846u64,
                                ))))))) + ((current_base_row[300usize]) * (node_1571)))
                + ((current_base_row[301usize]) * (node_1505))) * (node_3926))
                + ((node_113) * (next_base_row[8usize])),
            ((((((((((((((((((((((((((((((((((((((((((((((current_base_row[216usize])
                * (node_124)) + ((current_base_row[205usize]) * (node_529)))
                + ((current_base_row[220usize]) * (node_124)))
                + ((current_base_row[206usize]) * (current_base_row[323usize])))
                + ((current_base_row[225usize]) * (current_base_row[323usize])))
                + ((current_base_row[233usize]) * (node_120)))
                + ((current_base_row[236usize]) * (node_124)))
                + ((current_base_row[213usize])
                    * ((node_1184) * (current_base_row[22usize]))))
                + ((current_base_row[240usize])
                    * (((next_base_row[20usize]) + (node_112))
                        + (BFieldElement::from_raw_u64(18446744060824649731u64)))))
                + ((current_base_row[265usize]) * (node_1250)))
                + ((current_base_row[241usize]) * (node_120)))
                + ((current_base_row[242usize])
                    * (((node_1255) * (node_1252))
                        + ((current_base_row[271usize]) * (node_128)))))
                + ((current_base_row[223usize]) * (node_120)))
                + ((current_base_row[218usize]) * (node_124)))
                + ((current_base_row[224usize]) * (node_124)))
                + ((current_base_row[230usize]) * (node_124)))
                + ((current_base_row[232usize])
                    * ((current_base_row[28usize]) + (node_530))))
                + ((current_base_row[257usize]) * (node_124)))
                + ((current_base_row[258usize]) * (node_124)))
                + ((current_base_row[260usize]) * (node_120)))
                + ((current_base_row[262usize]) * (node_124)))
                + ((current_base_row[228usize]) * (node_120)))
                + ((current_base_row[261usize]) * (node_120)))
                + ((current_base_row[229usize]) * (node_120)))
                + ((current_base_row[263usize]) * (node_120)))
                + ((current_base_row[235usize]) * ((node_1915) * (node_1918))))
                + (current_base_row[358usize]))
                + ((current_base_row[234usize]) * (node_124)))
                + ((current_base_row[238usize]) * (node_124)))
                + ((current_base_row[243usize]) * (node_124)))
                + ((current_base_row[270usize]) * (node_124)))
                + ((current_base_row[250usize]) * (node_124)))
                + ((current_base_row[266usize]) * (node_120)))
                + ((current_base_row[273usize]) * (node_124)))
                + ((current_base_row[268usize]) * ((node_1968) + (node_536))))
                + ((current_base_row[269usize])
                    * ((next_base_row[23usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((((current_base_row[23usize])
                                * (current_base_row[25usize]))
                                + ((current_base_row[22usize])
                                    * (current_base_row[26usize])))
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (current_base_row[327usize]))) + (node_1983))))))
                + ((current_base_row[281usize])
                    * ((((((current_base_row[23usize]) * (next_base_row[22usize]))
                        + ((current_base_row[22usize]) * (next_base_row[23usize])))
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (current_base_row[328usize]))) + (node_1997))
                        + (node_2000))))
                + ((current_base_row[282usize])
                    * ((next_base_row[23usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * ((current_base_row[24usize])
                                * (current_base_row[22usize]))))))
                + ((current_base_row[275usize]) * (node_124)))
                + ((current_base_row[276usize]) * (node_124)))
                + ((current_base_row[298usize]) * (node_2126)))
                + (current_ext_row[85usize]))
                + ((current_base_row[300usize]) * (node_2210)))
                + ((current_base_row[301usize]) * (node_2210))) * (node_3926))
                + ((node_1181) * (next_base_row[8usize])),
            ((((((((((((((((((((((((((((((((((((((((((((((current_base_row[216usize])
                * (node_128)) + ((current_base_row[205usize]) * (node_531)))
                + ((current_base_row[220usize]) * (node_128)))
                + ((current_base_row[206usize]) * (current_base_row[303usize])))
                + ((current_base_row[225usize]) * (current_base_row[303usize])))
                + ((current_base_row[233usize]) * (node_124)))
                + ((current_base_row[236usize]) * (node_128)))
                + ((current_base_row[213usize])
                    * ((((((current_base_row[11usize]) + (node_292))
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * ((BFieldElement::from_raw_u64(8589934590u64))
                                * (current_base_row[41usize])))) + (node_144))
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * ((BFieldElement::from_raw_u64(137438953440u64))
                                * (current_base_row[43usize]))))
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * ((BFieldElement::from_raw_u64(549755813760u64))
                                * (current_base_row[44usize]))))))
                + ((current_base_row[240usize])
                    * ((next_base_row[21usize]) + (node_525))))
                + ((current_base_row[265usize]) * (node_261)))
                + ((current_base_row[241usize]) * (node_124)))
                + ((current_base_row[242usize])
                    * (((node_1255) * (node_1250))
                        + ((current_base_row[271usize]) * (node_1251)))))
                + ((current_base_row[223usize]) * (node_124)))
                + ((current_base_row[218usize]) * (node_128)))
                + ((current_base_row[224usize]) * (node_128)))
                + ((current_base_row[230usize]) * (node_128)))
                + ((current_base_row[232usize])
                    * ((current_base_row[29usize]) + (node_532))))
                + ((current_base_row[257usize]) * (node_128)))
                + ((current_base_row[258usize]) * (node_128)))
                + ((current_base_row[260usize]) * (node_124)))
                + ((current_base_row[262usize]) * (node_128)))
                + ((current_base_row[228usize]) * (node_124)))
                + ((current_base_row[261usize]) * (node_124)))
                + ((current_base_row[229usize]) * (node_124)))
                + ((current_base_row[263usize]) * (node_124)))
                + ((current_base_row[235usize])
                    * ((next_base_row[22usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (node_1918)))))
                + ((current_base_row[237usize]) * (node_531)))
                + ((current_base_row[234usize]) * (node_128)))
                + ((current_base_row[238usize]) * (node_128)))
                + ((current_base_row[243usize]) * (node_128)))
                + ((current_base_row[270usize]) * (node_128)))
                + ((current_base_row[250usize]) * (node_128)))
                + ((current_base_row[266usize]) * (node_124)))
                + ((current_base_row[273usize]) * (node_128)))
                + ((current_base_row[268usize]) * ((node_1970) + (node_538))))
                + ((current_base_row[269usize])
                    * ((next_base_row[24usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((((current_base_row[24usize])
                                * (current_base_row[25usize]))
                                + ((current_base_row[23usize])
                                    * (current_base_row[26usize])))
                                + ((current_base_row[22usize])
                                    * (current_base_row[27usize])))
                                + (current_base_row[327usize]))))))
                + ((current_base_row[281usize])
                    * (((((current_base_row[24usize]) * (next_base_row[22usize]))
                        + (node_1934))
                        + ((current_base_row[22usize]) * (next_base_row[24usize])))
                        + (current_base_row[328usize]))))
                + ((current_base_row[282usize])
                    * ((next_base_row[24usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (node_1972)))))
                + ((current_base_row[275usize]) * (node_128)))
                + ((current_base_row[276usize]) * (node_128)))
                + ((current_base_row[298usize]) * (node_120)))
                + ((current_base_row[297usize]) * (current_base_row[295usize])))
                + ((current_base_row[300usize])
                    * ((current_ext_row[83usize]) + (node_2186))))
                + ((current_base_row[301usize])
                    * (((current_ext_row[7usize]) * (current_ext_row[73usize]))
                        + (node_2186)))) * (node_3926))
                + (((next_base_row[11usize]) + (node_525)) * (next_base_row[8usize])),
            ((((((((((((((((((((((((((((((((((((((((((((((current_base_row[216usize])
                * (node_116)) + ((current_base_row[205usize]) * (node_533)))
                + ((current_base_row[220usize]) * (node_116)))
                + ((current_base_row[206usize]) * (current_base_row[249usize])))
                + ((current_base_row[225usize]) * (current_base_row[249usize])))
                + ((current_base_row[233usize]) * (node_128)))
                + ((current_base_row[236usize]) * (node_1182)))
                + (current_base_row[359usize]))
                + ((current_base_row[240usize])
                    * ((next_base_row[9usize]) + (node_525))))
                + ((current_base_row[265usize]) * (node_1177)))
                + ((current_base_row[241usize]) * (node_128)))
                + ((current_base_row[242usize])
                    * (((node_1255) * (node_1249))
                        + ((current_base_row[271usize]) * (node_120)))))
                + ((current_base_row[223usize]) * (node_128)))
                + ((current_base_row[218usize]) * (node_116)))
                + ((current_base_row[224usize]) * (node_116)))
                + ((current_base_row[230usize]) * (node_1182)))
                + ((current_base_row[232usize])
                    * ((current_base_row[30usize]) + (node_534))))
                + ((current_base_row[257usize]) * (node_1182)))
                + ((current_base_row[258usize]) * (node_1182)))
                + ((current_base_row[260usize]) * (node_128)))
                + ((current_base_row[262usize]) * (node_1182)))
                + ((current_base_row[228usize]) * (node_128)))
                + ((current_base_row[261usize]) * (node_128)))
                + ((current_base_row[229usize]) * (node_128)))
                + ((current_base_row[263usize]) * (node_128)))
                + ((current_base_row[235usize]) * (node_120)))
                + ((current_base_row[237usize]) * (node_533)))
                + ((current_base_row[234usize]) * (node_1182)))
                + ((current_base_row[238usize]) * (node_1182)))
                + ((current_base_row[243usize]) * (node_1182)))
                + ((current_base_row[270usize]) * (node_1182)))
                + ((current_base_row[250usize]) * (node_1182)))
                + ((current_base_row[266usize]) * (node_128)))
                + ((current_base_row[273usize]) * (node_1182)))
                + ((current_base_row[268usize]) * (node_1585)))
                + ((current_base_row[269usize]) * (node_1585)))
                + ((current_base_row[281usize]) * (node_261)))
                + ((current_base_row[282usize]) * (node_1232)))
                + ((current_base_row[275usize]) * (node_116)))
                + ((current_base_row[276usize]) * (node_116)))
                + ((current_base_row[298usize]) * (node_124)))
                + ((current_base_row[297usize]) * (node_2126)))
                + ((current_base_row[300usize])
                    * ((node_1970)
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * ((current_base_row[354usize])
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (node_2258)))))))
                + ((current_base_row[301usize])
                    * ((node_1970)
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * ((current_base_row[40usize])
                                * (current_base_row[39usize])))))) * (node_3926))
                + ((node_120) * (next_base_row[8usize])),
            ((((((((((((((((((((((((((((((((((((((((((((((current_base_row[216usize])
                * (current_base_row[323usize]))
                + ((current_base_row[205usize]) * (node_535)))
                + ((current_base_row[220usize]) * (current_base_row[323usize])))
                + ((current_base_row[206usize]) * (current_base_row[254usize])))
                + ((current_base_row[225usize]) * (current_base_row[254usize])))
                + ((current_base_row[233usize]) * (node_1182)))
                + ((current_base_row[236usize]) * (node_261)))
                + ((current_base_row[213usize]) * (current_base_row[303usize])))
                + ((current_base_row[240usize]) * (node_261)))
                + ((current_base_row[265usize]) * (node_864)))
                + ((current_base_row[241usize]) * (node_261)))
                + ((current_base_row[242usize]) * (node_261)))
                + ((current_base_row[223usize]) * (node_1182)))
                + ((current_base_row[218usize]) * (current_base_row[323usize])))
                + ((current_base_row[224usize]) * (current_base_row[323usize])))
                + ((current_base_row[230usize]) * (node_1661)))
                + ((current_base_row[232usize])
                    * ((current_base_row[31usize]) + (node_536))))
                + ((current_base_row[257usize]) * (node_261)))
                + ((current_base_row[258usize])
                    * ((node_261) + (BFieldElement::from_raw_u64(42949672950u64)))))
                + ((current_base_row[260usize]) * (node_1182)))
                + ((current_base_row[262usize])
                    * ((node_261)
                        + (BFieldElement::from_raw_u64(18446744026464911371u64)))))
                + ((current_base_row[228usize]) * (node_1182)))
                + ((current_base_row[261usize]) * (node_116)))
                + ((current_base_row[229usize]) * (node_1182)))
                + ((current_base_row[263usize]) * (node_1182)))
                + ((current_base_row[235usize]) * (node_124)))
                + ((current_base_row[237usize]) * (node_535)))
                + ((current_base_row[234usize]) * (node_1230)))
                + ((current_base_row[238usize]) * (node_1230)))
                + ((current_base_row[243usize]) * (node_1230)))
                + ((current_base_row[270usize]) * (node_261)))
                + ((current_base_row[250usize]) * (node_1230)))
                + ((current_base_row[266usize]) * (node_1182)))
                + ((current_base_row[273usize]) * (node_261)))
                + ((current_base_row[268usize]) * (node_1586)))
                + ((current_base_row[269usize]) * (node_1586)))
                + ((current_base_row[281usize]) * (node_1177)))
                + ((current_base_row[282usize]) * (node_1233)))
                + ((current_base_row[275usize]) * (current_base_row[323usize])))
                + ((current_base_row[276usize]) * (current_base_row[323usize])))
                + ((current_base_row[298usize]) * (node_128)))
                + ((current_base_row[297usize]) * (node_120)))
                + ((current_base_row[300usize])
                    * ((node_2268)
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((((current_base_row[40usize])
                                * (current_base_row[42usize]))
                                + ((current_base_row[39usize])
                                    * (current_base_row[43usize])))
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (node_2259))) + (node_2258))))))
                + ((current_base_row[301usize])
                    * ((node_2268)
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * ((current_base_row[41usize])
                                * (current_base_row[39usize])))))) * (node_3926))
                + ((node_124) * (next_base_row[8usize])),
            ((((((((((((((((((((((((((((((((((((((((((((((current_base_row[216usize])
                * (current_base_row[303usize]))
                + ((current_base_row[205usize]) * (node_537)))
                + ((current_base_row[220usize]) * (current_base_row[303usize])))
                + ((current_base_row[206usize]) * (node_154)))
                + ((current_base_row[225usize]) * (node_154)))
                + ((current_base_row[233usize]) * (node_261)))
                + ((current_base_row[236usize]) * (node_1177)))
                + (current_base_row[360usize]))
                + ((current_base_row[240usize]) * (node_1177)))
                + ((current_base_row[265usize]) * (node_516)))
                + ((current_base_row[241usize]) * (node_1177)))
                + ((current_base_row[242usize]) * (node_1177)))
                + ((current_base_row[223usize]) * (node_812)))
                + ((current_base_row[218usize]) * (current_base_row[303usize])))
                + ((current_base_row[224usize]) * (current_base_row[303usize])))
                + ((current_base_row[230usize]) * (node_1662)))
                + ((current_base_row[232usize]) * (node_120)))
                + ((current_base_row[257usize]) * (node_1177)))
                + ((current_base_row[258usize])
                    * ((node_201)
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * ((((((node_1050)
                                + ((challenges[33usize]) * (current_base_row[33usize])))
                                + ((challenges[34usize]) * (current_base_row[34usize])))
                                + ((challenges[35usize]) * (current_base_row[35usize])))
                                + ((challenges[36usize]) * (current_base_row[36usize])))
                                + ((challenges[37usize]) * (current_base_row[37usize])))))))
                + ((current_base_row[260usize]) * (node_261)))
                + ((current_base_row[262usize])
                    * ((((((((challenges[32usize]) * (next_base_row[32usize]))
                        + ((challenges[33usize]) * (next_base_row[33usize])))
                        + ((challenges[34usize]) * (next_base_row[34usize])))
                        + ((challenges[35usize]) * (next_base_row[35usize])))
                        + ((challenges[36usize]) * (next_base_row[36usize])))
                        + ((challenges[37usize]) * (next_base_row[37usize])))
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (node_607)))))
                + ((current_base_row[228usize]) * (node_1230)))
                + ((current_base_row[261usize]) * (node_261)))
                + ((current_base_row[229usize]) * (node_1230)))
                + ((current_base_row[263usize]) * (node_261)))
                + ((current_base_row[235usize]) * (node_128)))
                + ((current_base_row[237usize]) * (node_537)))
                + ((current_base_row[234usize]) * (node_1231)))
                + ((current_base_row[238usize]) * (node_1231)))
                + ((current_base_row[243usize]) * (node_1231)))
                + ((current_base_row[270usize]) * (node_1177)))
                + ((current_base_row[250usize]) * (node_1231)))
                + ((current_base_row[266usize]) * (node_261)))
                + ((current_base_row[273usize]) * (node_1177)))
                + ((current_base_row[268usize]) * (node_1587)))
                + ((current_base_row[269usize]) * (node_1587)))
                + ((current_base_row[281usize])
                    * ((((((((((((((node_194) + (node_197)) + (node_200)) + (node_203))
                        + (node_206)) + (node_209)) + (node_212)) + (node_215))
                        + (node_218)) + (node_221)) + (node_224)) + (node_227))
                        + (node_859))
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((((((((((((node_602) + (node_604)) + (node_606))
                                + (node_608)) + (node_610)) + (node_612)) + (node_614))
                                + (node_616)) + (node_618)) + (node_620)) + (node_622))
                                + (node_624)) + (node_861))))))
                + ((current_base_row[282usize]) * (node_1234)))
                + ((current_base_row[275usize]) * (current_base_row[303usize])))
                + ((current_base_row[276usize]) * (current_base_row[303usize])))
                + ((current_base_row[298usize]) * (node_1182)))
                + ((current_base_row[297usize]) * (node_124)))
                + ((current_base_row[300usize])
                    * ((node_2271)
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * ((((current_base_row[210usize])
                                + ((current_base_row[40usize])
                                    * (current_base_row[43usize])))
                                + ((current_base_row[39usize])
                                    * (current_base_row[44usize]))) + (node_2259))))))
                + ((current_base_row[301usize])
                    * ((node_2271)
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (current_base_row[354usize]))))) * (node_3926))
                + ((node_128) * (next_base_row[8usize])),
            ((((((((((((((((((((((((((((((((((((((((((((((current_base_row[216usize])
                * (current_base_row[249usize]))
                + ((current_base_row[205usize]) * (node_539)))
                + ((current_base_row[220usize]) * (current_base_row[249usize])))
                + ((current_base_row[206usize]) * (node_120)))
                + ((current_base_row[225usize]) * (node_120)))
                + ((current_base_row[233usize]) * (node_1177)))
                + ((current_base_row[236usize]) * (node_864)))
                + (current_base_row[361usize]))
                + ((current_base_row[240usize]) * (node_864)))
                + ((current_base_row[265usize]) * (node_520)))
                + ((current_base_row[241usize]) * (node_864)))
                + ((current_base_row[242usize]) * (node_864)))
                + ((current_base_row[223usize]) * (node_1230)))
                + ((current_base_row[218usize]) * (current_base_row[249usize])))
                + ((current_base_row[224usize]) * (current_base_row[249usize])))
                + ((current_base_row[230usize]) * (node_1663)))
                + ((current_base_row[232usize]) * (node_124)))
                + ((current_base_row[257usize]) * (node_864)))
                + ((current_base_row[258usize])
                    * ((next_ext_row[6usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (current_ext_row[67usize])))))
                + ((current_base_row[260usize]) * (node_1177)))
                + ((current_base_row[262usize])
                    * ((next_ext_row[6usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (current_ext_row[68usize])))))
                + ((current_base_row[228usize]) * (node_1231)))
                + ((current_base_row[261usize]) * (node_1177)))
                + ((current_base_row[229usize]) * (node_1231)))
                + ((current_base_row[263usize]) * (node_1177)))
                + ((current_base_row[235usize]) * (node_1182)))
                + ((current_base_row[237usize]) * (node_539)))
                + ((current_base_row[234usize]) * (node_1232)))
                + ((current_base_row[238usize]) * (node_1232)))
                + ((current_base_row[243usize]) * (node_1232)))
                + ((current_base_row[270usize]) * (node_1909)))
                + ((current_base_row[250usize]) * (node_1232)))
                + ((current_base_row[266usize]) * (node_1177)))
                + ((current_base_row[273usize]) * (node_1909)))
                + ((current_base_row[268usize]) * (node_1588)))
                + ((current_base_row[269usize]) * (node_1588)))
                + ((current_base_row[281usize]) * (node_120)))
                + ((current_base_row[282usize]) * (node_1235)))
                + ((current_base_row[275usize]) * (current_base_row[249usize])))
                + ((current_base_row[276usize]) * (current_base_row[249usize])))
                + ((current_base_row[298usize]) * (node_520)))
                + ((current_base_row[297usize]) * (node_128)))
                + ((current_base_row[300usize]) * (node_120)))
                + ((current_base_row[301usize]) * (node_120))) * (node_3926))
                + ((node_261) * (next_base_row[8usize])),
            ((((((((((((((((((((((((((((((((((((((((((((((current_base_row[216usize])
                * (current_base_row[254usize]))
                + ((current_base_row[205usize]) * (node_541)))
                + ((current_base_row[220usize]) * (current_base_row[254usize])))
                + ((current_base_row[206usize]) * (node_124)))
                + ((current_base_row[225usize]) * (node_124)))
                + ((current_base_row[233usize]) * (node_864)))
                + ((current_base_row[236usize]) * (node_516)))
                + ((current_base_row[213usize]) * (current_base_row[299usize])))
                + ((current_base_row[240usize]) * (node_516)))
                + ((current_base_row[265usize]) * (node_524)))
                + ((current_base_row[241usize]) * (node_516)))
                + ((current_base_row[242usize]) * (node_516)))
                + ((current_base_row[223usize]) * (node_1231)))
                + ((current_base_row[218usize]) * (current_base_row[254usize])))
                + ((current_base_row[224usize]) * (current_base_row[254usize])))
                + ((current_base_row[230usize]) * (node_1664)))
                + ((current_base_row[232usize]) * (node_128)))
                + ((current_base_row[257usize]) * (node_516)))
                + ((current_base_row[258usize]) * (node_516)))
                + ((current_base_row[260usize]) * (node_1820)))
                + ((current_base_row[262usize]) * (node_516)))
                + ((current_base_row[228usize]) * (node_1232)))
                + ((current_base_row[261usize]) * (node_1909)))
                + ((current_base_row[229usize]) * (node_1232)))
                + ((current_base_row[263usize]) * (node_1909)))
                + ((current_base_row[235usize]) * (node_1230)))
                + ((current_base_row[237usize]) * (node_541)))
                + ((current_base_row[234usize]) * (node_1233)))
                + ((current_base_row[238usize]) * (node_1233)))
                + ((current_base_row[243usize]) * (node_1233)))
                + ((current_base_row[270usize]) * (node_516)))
                + ((current_base_row[250usize]) * (node_1233)))
                + ((current_base_row[266usize])
                    * (((((((((((((((node_191) + (node_194)) + (node_197)) + (node_200))
                        + (node_203)) + (node_206)) + (node_209)) + (node_212))
                        + (node_215)) + (node_218)) + (node_221)) + (node_224))
                        + (node_227)) + (node_859))
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * ((((((((((((((node_600) + (node_602)) + (node_604))
                                + (node_606)) + (node_608)) + (node_610)) + (node_612))
                                + (node_614)) + (node_616)) + (node_618)) + (node_620))
                                + (node_622)) + (node_624)) + (node_861))))))
                + ((current_base_row[273usize]) * (node_516)))
                + ((current_base_row[268usize]) * (node_1589)))
                + ((current_base_row[269usize]) * (node_1589)))
                + ((current_base_row[281usize]) * (node_124)))
                + ((current_base_row[282usize]) * (node_1236)))
                + ((current_base_row[275usize]) * (current_base_row[254usize])))
                + ((current_base_row[276usize]) * (current_base_row[254usize])))
                + ((current_base_row[298usize]) * (node_524)))
                + ((current_base_row[297usize]) * (node_1182)))
                + ((current_base_row[300usize]) * (node_124)))
                + ((current_base_row[301usize]) * (node_124))) * (node_3926))
                + ((node_1177) * (next_base_row[8usize])),
            (((((((((((((((((((((((((((((((((((((((((((((current_base_row[216usize])
                * (node_154)) + ((current_base_row[205usize]) * (node_543)))
                + ((current_base_row[220usize]) * (node_154)))
                + ((current_base_row[206usize]) * (node_128)))
                + ((current_base_row[225usize]) * (node_128)))
                + ((current_base_row[233usize]) * (node_516)))
                + ((current_base_row[236usize]) * (node_520)))
                + (current_base_row[362usize]))
                + ((current_base_row[240usize]) * (node_520)))
                + ((current_base_row[241usize]) * (node_520)))
                + ((current_base_row[242usize]) * (node_520)))
                + ((current_base_row[223usize]) * (node_1232)))
                + ((current_base_row[218usize]) * (node_154)))
                + ((current_base_row[224usize]) * (node_154)))
                + ((current_base_row[230usize]) * (node_1665)))
                + ((current_base_row[232usize]) * (node_1182)))
                + ((current_base_row[257usize]) * (node_520)))
                + ((current_base_row[258usize]) * (node_520)))
                + ((current_base_row[260usize]) * (node_520)))
                + ((current_base_row[262usize]) * (node_520)))
                + ((current_base_row[228usize]) * (node_1233)))
                + ((current_base_row[261usize]) * (node_516)))
                + ((current_base_row[229usize]) * (node_1233)))
                + ((current_base_row[263usize]) * (node_516)))
                + ((current_base_row[235usize]) * (node_1231)))
                + ((current_base_row[237usize]) * (node_543)))
                + ((current_base_row[234usize]) * (node_1234)))
                + ((current_base_row[238usize]) * (node_1234)))
                + ((current_base_row[243usize]) * (node_1234)))
                + ((current_base_row[270usize]) * (node_520)))
                + ((current_base_row[250usize]) * (node_1234)))
                + ((current_base_row[266usize]) * (node_516)))
                + ((current_base_row[273usize]) * (node_520)))
                + ((current_base_row[268usize]) * (node_1590)))
                + ((current_base_row[269usize]) * (node_1590)))
                + ((current_base_row[281usize]) * (node_128)))
                + ((current_base_row[282usize]) * (node_1237)))
                + ((current_base_row[275usize]) * (node_154)))
                + ((current_base_row[276usize]) * (node_154)))
                + ((current_base_row[298usize]) * (node_261)))
                + ((current_base_row[297usize]) * (node_520)))
                + ((current_base_row[300usize]) * (node_128)))
                + ((current_base_row[301usize]) * (node_128))) * (node_3926))
                + ((node_864) * (next_base_row[8usize])),
            (((((((((((((((((((((((((((((((((((((((((((((current_base_row[216usize])
                * (node_476)) + ((current_base_row[205usize]) * (node_545)))
                + ((current_base_row[220usize]) * (node_801)))
                + ((current_base_row[206usize]) * (node_116)))
                + ((current_base_row[225usize]) * (node_116)))
                + ((current_base_row[233usize]) * (node_520)))
                + ((current_base_row[236usize]) * (node_524)))
                + ((current_base_row[213usize]) * (node_120)))
                + ((current_base_row[240usize]) * (node_524)))
                + ((current_base_row[241usize]) * (node_524)))
                + ((current_base_row[242usize]) * (node_524)))
                + ((current_base_row[223usize]) * (node_1233)))
                + ((current_base_row[218usize]) * (node_801)))
                + ((current_base_row[224usize]) * (node_476)))
                + ((current_base_row[230usize]) * (node_1666)))
                + ((current_base_row[232usize]) * (node_455)))
                + ((current_base_row[257usize]) * (node_524)))
                + ((current_base_row[258usize]) * (node_524)))
                + ((current_base_row[260usize]) * (node_524)))
                + ((current_base_row[262usize]) * (node_524)))
                + ((current_base_row[228usize]) * (node_1234)))
                + ((current_base_row[261usize]) * (node_520)))
                + ((current_base_row[229usize]) * (node_1234)))
                + ((current_base_row[263usize]) * (node_520)))
                + ((current_base_row[235usize]) * (node_1232)))
                + ((current_base_row[237usize]) * (node_545)))
                + ((current_base_row[234usize]) * (node_1235)))
                + ((current_base_row[238usize]) * (node_1235)))
                + ((current_base_row[243usize]) * (node_1235)))
                + ((current_base_row[270usize]) * (node_524)))
                + ((current_base_row[250usize]) * (node_1235)))
                + ((current_base_row[266usize]) * (node_520)))
                + ((current_base_row[273usize]) * (node_524)))
                + ((current_base_row[268usize]) * (node_1591)))
                + ((current_base_row[269usize]) * (node_1591)))
                + ((current_base_row[281usize]) * (node_1182)))
                + ((current_base_row[282usize]) * (node_1238)))
                + ((current_base_row[275usize]) * (node_801)))
                + ((current_base_row[276usize]) * (node_476)))
                + ((current_base_row[298usize]) * (node_1177)))
                + ((current_base_row[297usize]) * (node_524)))
                + ((current_base_row[300usize]) * (node_1182)))
                + ((current_base_row[301usize]) * (node_1182))) * (node_3926))
                + ((node_516) * (next_base_row[8usize])),
            (((((((((((((((((((((((((((((((((((current_base_row[216usize]) * (node_480))
                + ((current_base_row[205usize]) * (node_547)))
                + ((current_base_row[220usize]) * (node_805)))
                + ((current_base_row[206usize]) * (node_529)))
                + ((current_base_row[225usize]) * (node_516)))
                + ((current_base_row[233usize]) * (node_524)))
                + ((current_base_row[213usize]) * (node_124)))
                + ((current_base_row[223usize]) * (node_1234)))
                + ((current_base_row[218usize])
                    * ((((((current_base_row[195usize])
                        * ((node_810) + (BFieldElement::from_raw_u64(4294967295u64))))
                        + ((current_base_row[196usize])
                            * ((node_810)
                                + (BFieldElement::from_raw_u64(8589934590u64)))))
                        + ((current_base_row[197usize])
                            * ((node_810)
                                + (BFieldElement::from_raw_u64(12884901885u64)))))
                        + ((current_base_row[198usize])
                            * ((node_810)
                                + (BFieldElement::from_raw_u64(17179869180u64)))))
                        + ((current_base_row[199usize])
                            * ((node_810)
                                + (BFieldElement::from_raw_u64(21474836475u64)))))))
                + ((current_base_row[224usize])
                    * ((((((current_base_row[195usize]) * (node_1505))
                        + ((current_base_row[196usize])
                            * ((node_810)
                                + (BFieldElement::from_raw_u64(18446744060824649731u64)))))
                        + ((current_base_row[197usize]) * (node_1571)))
                        + ((current_base_row[198usize])
                            * ((node_810)
                                + (BFieldElement::from_raw_u64(18446744052234715141u64)))))
                        + ((current_base_row[199usize])
                            * ((node_810)
                                + (BFieldElement::from_raw_u64(
                                    18446744047939747846u64,
                                ))))))) + ((current_base_row[230usize]) * (node_455)))
                + ((current_base_row[232usize]) * (node_457)))
                + ((current_base_row[228usize]) * (node_1235)))
                + ((current_base_row[261usize]) * (node_524)))
                + ((current_base_row[229usize]) * (node_1235)))
                + ((current_base_row[263usize]) * (node_524)))
                + ((current_base_row[235usize]) * (node_1233)))
                + ((current_base_row[237usize]) * (node_547)))
                + ((current_base_row[234usize]) * (node_1236)))
                + ((current_base_row[238usize]) * (node_1236)))
                + ((current_base_row[243usize]) * (node_1236)))
                + ((current_base_row[250usize]) * (node_1236)))
                + ((current_base_row[266usize]) * (node_524)))
                + ((current_base_row[268usize]) * (node_1592)))
                + ((current_base_row[269usize]) * (node_1592)))
                + ((current_base_row[281usize]) * (node_516)))
                + ((current_base_row[282usize]) * (node_1239)))
                + ((current_base_row[275usize]) * (node_805)))
                + ((current_base_row[276usize]) * (node_480)))
                + ((current_base_row[298usize])
                    * (((((((((((node_203) + (node_206)) + (node_209)) + (node_212))
                        + (node_215)) + (node_218)) + (node_221)) + (node_224))
                        + (node_227)) + (node_859))
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * ((((((((((node_608) + (node_610)) + (node_612))
                                + (node_614)) + (node_616)) + (node_618)) + (node_620))
                                + (node_622)) + (node_624)) + (node_861))))))
                + ((current_base_row[297usize]) * (node_261)))
                + ((current_base_row[300usize]) * (node_520)))
                + ((current_base_row[301usize]) * (node_520))) * (node_3926))
                + ((node_520) * (next_base_row[8usize])),
            (((((((((((((((((((((((((((((((current_base_row[216usize]) * (node_484))
                + ((current_base_row[205usize]) * (node_549)))
                + ((current_base_row[220usize]) * (node_809)))
                + ((current_base_row[206usize]) * (node_531)))
                + ((current_base_row[225usize]) * (node_520)))
                + ((current_base_row[213usize]) * (node_128)))
                + ((current_base_row[223usize]) * (node_1235)))
                + ((current_base_row[218usize]) * (node_809)))
                + ((current_base_row[224usize]) * (node_484)))
                + ((current_base_row[230usize]) * (node_468)))
                + ((current_base_row[232usize]) * (node_468)))
                + ((current_base_row[228usize]) * (node_1236)))
                + ((current_base_row[229usize]) * (node_1236)))
                + ((current_base_row[235usize]) * (node_1234)))
                + ((current_base_row[237usize]) * (node_549)))
                + ((current_base_row[234usize]) * (node_1237)))
                + ((current_base_row[238usize]) * (node_1237)))
                + ((current_base_row[243usize]) * (node_1237)))
                + ((current_base_row[250usize]) * (node_1237)))
                + ((current_base_row[268usize]) * (node_1593)))
                + ((current_base_row[269usize]) * (node_1593)))
                + ((current_base_row[281usize]) * (node_520)))
                + ((current_base_row[282usize]) * (node_1240)))
                + ((current_base_row[275usize]) * (node_809)))
                + ((current_base_row[276usize]) * (node_484)))
                + ((current_base_row[298usize]) * (node_516)))
                + ((current_base_row[297usize]) * (node_1177)))
                + ((current_base_row[300usize]) * (node_524)))
                + ((current_base_row[301usize]) * (node_524))) * (node_3926))
                + ((node_524) * (next_base_row[8usize])),
            (((((((((((((((((((((((((((((current_base_row[216usize]) * (node_512))
                + ((current_base_row[205usize]) * (node_551)))
                + ((current_base_row[220usize]) * (node_512)))
                + ((current_base_row[206usize]) * (node_533)))
                + ((current_base_row[225usize]) * (node_524)))
                + ((current_base_row[213usize]) * (node_812)))
                + ((current_base_row[223usize]) * (node_1236)))
                + (current_ext_row[86usize])) + (current_ext_row[87usize]))
                + ((current_base_row[230usize]) * (node_516)))
                + ((current_base_row[232usize]) * (node_516)))
                + ((current_base_row[228usize]) * (node_1237)))
                + ((current_base_row[229usize]) * (node_1237)))
                + ((current_base_row[235usize]) * (node_1235)))
                + ((current_base_row[237usize]) * (node_551)))
                + ((current_base_row[234usize]) * (node_1238)))
                + ((current_base_row[238usize]) * (node_1238)))
                + ((current_base_row[243usize]) * (node_1238)))
                + ((current_base_row[250usize]) * (node_1238)))
                + ((current_base_row[268usize]) * (node_1594)))
                + ((current_base_row[269usize]) * (node_1594)))
                + ((current_base_row[281usize]) * (node_524)))
                + ((current_base_row[282usize]) * (node_1241)))
                + ((current_base_row[275usize])
                    * ((((((current_base_row[195usize])
                        * ((next_ext_row[3usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * ((node_2049) + (next_base_row[22usize])))))
                        + ((current_base_row[196usize])
                            * ((next_ext_row[3usize])
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (((challenges[1usize])
                                        * ((node_2049) + (next_base_row[23usize])))
                                        + (next_base_row[22usize]))))))
                        + ((current_base_row[197usize])
                            * ((next_ext_row[3usize])
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (((challenges[1usize])
                                        * (((challenges[1usize])
                                            * ((node_2049) + (next_base_row[24usize])))
                                            + (next_base_row[23usize]))) + (next_base_row[22usize]))))))
                        + ((current_base_row[198usize])
                            * ((next_ext_row[3usize])
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (((challenges[1usize])
                                        * (((challenges[1usize])
                                            * (((challenges[1usize])
                                                * ((node_2049) + (next_base_row[25usize])))
                                                + (next_base_row[24usize]))) + (next_base_row[23usize])))
                                        + (next_base_row[22usize]))))))
                        + ((current_base_row[199usize])
                            * ((next_ext_row[3usize])
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (((challenges[1usize])
                                        * (((challenges[1usize])
                                            * (((challenges[1usize])
                                                * (((challenges[1usize])
                                                    * ((node_2049) + (next_base_row[26usize])))
                                                    + (next_base_row[25usize]))) + (next_base_row[24usize])))
                                            + (next_base_row[23usize])))
                                        + (next_base_row[22usize]))))))))
                + ((current_base_row[276usize])
                    * ((((((current_base_row[195usize])
                        * ((next_ext_row[4usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (node_2096))))
                        + ((current_base_row[196usize])
                            * ((next_ext_row[4usize])
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (node_2101)))))
                        + ((current_base_row[197usize])
                            * ((next_ext_row[4usize])
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (node_2106)))))
                        + ((current_base_row[198usize])
                            * ((next_ext_row[4usize])
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (node_2111)))))
                        + ((current_base_row[199usize])
                            * ((next_ext_row[4usize])
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (((challenges[2usize]) * (node_2111))
                                        + (current_base_row[26usize]))))))))
                + ((current_base_row[297usize])
                    * (((((((((node_209) + (node_212)) + (node_215)) + (node_218))
                        + (node_221)) + (node_224)) + (node_227)) + (node_859))
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * ((((((((node_612) + (node_614)) + (node_616)) + (node_618))
                                + (node_620)) + (node_622)) + (node_624)) + (node_861))))))
                + ((current_base_row[300usize]) * (node_261)))
                + ((current_base_row[301usize]) * (node_261))) * (node_3926),
            (((((((((((((((((((((((((((current_base_row[216usize]) * (node_516))
                + ((current_base_row[205usize]) * (node_553)))
                + ((current_base_row[220usize]) * (node_516)))
                + ((current_base_row[206usize]) * (node_535)))
                + ((current_base_row[225usize]) * (node_261)))
                + ((current_base_row[213usize]) * (node_1230)))
                + ((current_base_row[223usize]) * (node_1237)))
                + ((current_base_row[218usize])
                    * ((((((current_base_row[195usize]) * (node_531))
                        + ((current_base_row[196usize])
                            * ((next_base_row[25usize]) + (node_530))))
                        + ((current_base_row[197usize])
                            * ((next_base_row[26usize]) + (node_530))))
                        + ((current_base_row[198usize])
                            * ((next_base_row[27usize]) + (node_530))))
                        + ((current_base_row[199usize])
                            * ((next_base_row[28usize]) + (node_530))))))
                + ((current_base_row[224usize])
                    * ((((((current_base_row[195usize]) * (node_1230))
                        + ((current_base_row[196usize])
                            * ((next_base_row[23usize]) + (node_534))))
                        + ((current_base_row[197usize])
                            * ((next_base_row[23usize]) + (node_536))))
                        + ((current_base_row[198usize])
                            * ((next_base_row[23usize]) + (node_538))))
                        + ((current_base_row[199usize])
                            * ((next_base_row[23usize]) + (node_540))))))
                + ((current_base_row[230usize]) * (node_520)))
                + ((current_base_row[232usize]) * (node_520)))
                + ((current_base_row[228usize]) * (node_1238)))
                + ((current_base_row[229usize]) * (node_1238)))
                + ((current_base_row[235usize]) * (node_1236)))
                + ((current_base_row[237usize]) * (node_553)))
                + ((current_base_row[234usize]) * (node_1239)))
                + ((current_base_row[238usize]) * (node_1239)))
                + ((current_base_row[243usize]) * (node_1239)))
                + ((current_base_row[250usize]) * (node_1239)))
                + ((current_base_row[268usize]) * (node_372)))
                + ((current_base_row[269usize]) * (node_372)))
                + ((current_base_row[282usize]) * (node_1242)))
                + ((current_base_row[275usize]) * (node_512)))
                + ((current_base_row[276usize]) * (node_512)))
                + ((current_base_row[300usize]) * (node_1177)))
                + ((current_base_row[301usize]) * (node_1177))) * (node_3926),
            (((((((((((((((((((((((((((current_base_row[216usize]) * (node_520))
                + ((current_base_row[205usize]) * (node_555)))
                + ((current_base_row[220usize]) * (node_520)))
                + ((current_base_row[206usize]) * (node_537)))
                + ((current_base_row[225usize]) * (node_1177)))
                + ((current_base_row[213usize]) * (node_1231)))
                + ((current_base_row[223usize]) * (node_1238)))
                + ((current_base_row[218usize])
                    * ((((((current_base_row[195usize]) * (node_533))
                        + ((current_base_row[196usize])
                            * ((next_base_row[26usize]) + (node_532))))
                        + ((current_base_row[197usize])
                            * ((next_base_row[27usize]) + (node_532))))
                        + ((current_base_row[198usize])
                            * ((next_base_row[28usize]) + (node_532))))
                        + ((current_base_row[199usize])
                            * ((next_base_row[29usize]) + (node_532))))))
                + ((current_base_row[224usize])
                    * ((((((current_base_row[195usize]) * (node_1231))
                        + ((current_base_row[196usize])
                            * ((next_base_row[24usize]) + (node_536))))
                        + ((current_base_row[197usize])
                            * ((next_base_row[24usize]) + (node_538))))
                        + ((current_base_row[198usize])
                            * ((next_base_row[24usize]) + (node_540))))
                        + ((current_base_row[199usize])
                            * ((next_base_row[24usize]) + (node_542))))))
                + ((current_base_row[230usize]) * (node_524)))
                + ((current_base_row[232usize]) * (node_524)))
                + ((current_base_row[228usize]) * (node_1239)))
                + ((current_base_row[229usize]) * (node_1239)))
                + ((current_base_row[235usize]) * (node_1237)))
                + ((current_base_row[237usize]) * (node_555)))
                + ((current_base_row[234usize]) * (node_1240)))
                + ((current_base_row[238usize]) * (node_1240)))
                + ((current_base_row[243usize]) * (node_1240)))
                + ((current_base_row[250usize]) * (node_1240)))
                + ((current_base_row[268usize]) * (node_385)))
                + ((current_base_row[269usize]) * (node_385)))
                + ((current_base_row[282usize]) * (node_1243)))
                + ((current_base_row[275usize]) * (node_516)))
                + ((current_base_row[276usize]) * (node_516)))
                + ((current_base_row[300usize]) * (node_1820)))
                + ((current_base_row[301usize]) * (node_1820))) * (node_3926),
            ((((((((((((((((((((((current_base_row[216usize]) * (node_524))
                + ((current_base_row[205usize]) * (node_557)))
                + ((current_base_row[220usize]) * (node_524)))
                + ((current_base_row[206usize]) * (node_539)))
                + ((current_base_row[213usize]) * (node_1232)))
                + ((current_base_row[223usize]) * (node_1239)))
                + ((current_base_row[218usize])
                    * ((((((current_base_row[195usize]) * (node_535))
                        + ((current_base_row[196usize])
                            * ((next_base_row[27usize]) + (node_534))))
                        + ((current_base_row[197usize])
                            * ((next_base_row[28usize]) + (node_534))))
                        + ((current_base_row[198usize])
                            * ((next_base_row[29usize]) + (node_534))))
                        + ((current_base_row[199usize])
                            * ((next_base_row[30usize]) + (node_534))))))
                + ((current_base_row[224usize])
                    * ((((((current_base_row[195usize]) * (node_1232))
                        + ((current_base_row[196usize])
                            * ((next_base_row[25usize]) + (node_538))))
                        + ((current_base_row[197usize]) * (node_1585)))
                        + ((current_base_row[198usize])
                            * ((next_base_row[25usize]) + (node_542))))
                        + ((current_base_row[199usize])
                            * ((next_base_row[25usize]) + (node_544))))))
                + ((current_base_row[228usize]) * (node_1240)))
                + ((current_base_row[229usize]) * (node_1240)))
                + ((current_base_row[235usize]) * (node_1238)))
                + ((current_base_row[237usize]) * (node_557)))
                + ((current_base_row[234usize]) * (node_1241)))
                + ((current_base_row[238usize]) * (node_1241)))
                + ((current_base_row[243usize]) * (node_1241)))
                + ((current_base_row[250usize]) * (node_1241)))
                + ((current_base_row[268usize]) * (node_120)))
                + ((current_base_row[269usize]) * (node_120)))
                + ((current_base_row[282usize]) * (node_262)))
                + ((current_base_row[275usize]) * (node_524)))
                + ((current_base_row[276usize]) * (node_520))) * (node_3926),
            ((((((((((((((((((current_base_row[205usize]) * (node_558))
                + ((current_base_row[206usize]) * (node_541)))
                + ((current_base_row[213usize]) * (node_1233)))
                + ((current_base_row[223usize]) * (node_1240)))
                + ((current_base_row[218usize])
                    * ((((((current_base_row[195usize]) * (node_537))
                        + ((current_base_row[196usize])
                            * ((next_base_row[28usize]) + (node_536))))
                        + ((current_base_row[197usize])
                            * ((next_base_row[29usize]) + (node_536))))
                        + ((current_base_row[198usize])
                            * ((next_base_row[30usize]) + (node_536))))
                        + ((current_base_row[199usize])
                            * ((next_base_row[31usize]) + (node_536))))))
                + ((current_base_row[224usize])
                    * ((((((current_base_row[195usize]) * (node_1233))
                        + ((current_base_row[196usize])
                            * ((next_base_row[26usize]) + (node_540))))
                        + ((current_base_row[197usize]) * (node_1586)))
                        + ((current_base_row[198usize])
                            * ((next_base_row[26usize]) + (node_544))))
                        + ((current_base_row[199usize])
                            * ((next_base_row[26usize]) + (node_546))))))
                + ((current_base_row[228usize]) * (node_1241)))
                + ((current_base_row[229usize]) * (node_1241)))
                + ((current_base_row[235usize]) * (node_1239)))
                + ((current_base_row[237usize]) * (node_558)))
                + ((current_base_row[234usize]) * (node_1242)))
                + ((current_base_row[238usize]) * (node_1242)))
                + ((current_base_row[243usize]) * (node_1242)))
                + ((current_base_row[250usize]) * (node_1242)))
                + ((current_base_row[268usize]) * (node_124)))
                + ((current_base_row[269usize]) * (node_124)))
                + ((current_base_row[282usize]) * (node_286))) * (node_3926),
            ((((((((((((((((((current_base_row[205usize]) * (node_567))
                + ((current_base_row[206usize]) * (node_543)))
                + ((current_base_row[213usize]) * (node_1234)))
                + ((current_base_row[223usize]) * (node_1241)))
                + ((current_base_row[218usize])
                    * ((((((current_base_row[195usize]) * (node_539))
                        + ((current_base_row[196usize])
                            * ((next_base_row[29usize]) + (node_538))))
                        + ((current_base_row[197usize])
                            * ((next_base_row[30usize]) + (node_538))))
                        + ((current_base_row[198usize])
                            * ((next_base_row[31usize]) + (node_538))))
                        + ((current_base_row[199usize])
                            * ((next_base_row[32usize]) + (node_538))))))
                + ((current_base_row[224usize])
                    * ((((((current_base_row[195usize]) * (node_1234))
                        + ((current_base_row[196usize])
                            * ((next_base_row[27usize]) + (node_542))))
                        + ((current_base_row[197usize]) * (node_1587)))
                        + ((current_base_row[198usize])
                            * ((next_base_row[27usize]) + (node_546))))
                        + ((current_base_row[199usize]) * (node_1661)))))
                + ((current_base_row[228usize]) * (node_1242)))
                + ((current_base_row[229usize]) * (node_1242)))
                + ((current_base_row[235usize]) * (node_1240)))
                + ((current_base_row[237usize]) * (node_567)))
                + ((current_base_row[234usize]) * (node_1243)))
                + ((current_base_row[238usize]) * (node_1243)))
                + ((current_base_row[243usize]) * (node_1243)))
                + ((current_base_row[250usize]) * (node_1243)))
                + ((current_base_row[268usize]) * (node_128)))
                + ((current_base_row[269usize]) * (node_128)))
                + ((current_base_row[282usize]) * (node_120))) * (node_3926),
            ((((((((((((((((((current_base_row[205usize]) * (node_124))
                + ((current_base_row[206usize]) * (node_547)))
                + ((current_base_row[213usize]) * (node_1236)))
                + ((current_base_row[223usize]) * (node_1243)))
                + ((current_base_row[218usize])
                    * ((((((current_base_row[195usize]) * (node_543))
                        + ((current_base_row[196usize])
                            * ((next_base_row[31usize]) + (node_542))))
                        + ((current_base_row[197usize])
                            * ((next_base_row[32usize]) + (node_542))))
                        + ((current_base_row[198usize])
                            * ((next_base_row[33usize]) + (node_542))))
                        + ((current_base_row[199usize])
                            * ((next_base_row[34usize]) + (node_542))))))
                + ((current_base_row[224usize])
                    * ((((((current_base_row[195usize]) * (node_1236))
                        + ((current_base_row[196usize])
                            * ((next_base_row[29usize]) + (node_546))))
                        + ((current_base_row[197usize]) * (node_1589)))
                        + ((current_base_row[198usize])
                            * ((next_base_row[29usize]) + (node_550))))
                        + ((current_base_row[199usize]) * (node_1663)))))
                + ((current_base_row[228usize]) * (node_262)))
                + ((current_base_row[229usize]) * (node_262)))
                + ((current_base_row[235usize]) * (node_1242)))
                + ((current_base_row[237usize]) * (node_124)))
                + ((current_base_row[234usize]) * (node_286)))
                + ((current_base_row[238usize]) * (node_286)))
                + ((current_base_row[243usize]) * (node_286)))
                + ((current_base_row[250usize]) * (node_286)))
                + ((current_base_row[268usize]) * (node_516)))
                + ((current_base_row[269usize]) * (node_516)))
                + ((current_base_row[282usize]) * (node_128))) * (node_3926),
            ((((((((((((((((((current_base_row[205usize]) * (node_128))
                + ((current_base_row[206usize]) * (node_549)))
                + ((current_base_row[213usize]) * (node_1237)))
                + ((current_base_row[223usize]) * (node_262)))
                + ((current_base_row[218usize])
                    * ((((((current_base_row[195usize]) * (node_545))
                        + ((current_base_row[196usize])
                            * ((next_base_row[32usize]) + (node_544))))
                        + ((current_base_row[197usize])
                            * ((next_base_row[33usize]) + (node_544))))
                        + ((current_base_row[198usize])
                            * ((next_base_row[34usize]) + (node_544))))
                        + ((current_base_row[199usize])
                            * ((next_base_row[35usize]) + (node_544))))))
                + ((current_base_row[224usize])
                    * ((((((current_base_row[195usize]) * (node_1237))
                        + ((current_base_row[196usize])
                            * ((next_base_row[30usize]) + (node_548))))
                        + ((current_base_row[197usize]) * (node_1590)))
                        + ((current_base_row[198usize])
                            * ((next_base_row[30usize]) + (node_552))))
                        + ((current_base_row[199usize]) * (node_1664)))))
                + ((current_base_row[228usize]) * (node_286)))
                + ((current_base_row[229usize]) * (node_286)))
                + ((current_base_row[235usize]) * (node_1243)))
                + ((current_base_row[237usize]) * (node_128)))
                + ((current_base_row[234usize]) * (node_516)))
                + ((current_base_row[238usize]) * (node_516)))
                + ((current_base_row[243usize]) * (node_516)))
                + ((current_base_row[250usize]) * (node_516)))
                + ((current_base_row[268usize]) * (node_520)))
                + ((current_base_row[269usize]) * (node_520)))
                + ((current_base_row[282usize]) * (node_1182))) * (node_3926),
            ((((((((((((((((((current_base_row[205usize]) * (node_116))
                + ((current_base_row[206usize]) * (node_551)))
                + ((current_base_row[213usize]) * (node_1238)))
                + ((current_base_row[223usize]) * (node_286)))
                + ((current_base_row[218usize])
                    * ((((((current_base_row[195usize]) * (node_547))
                        + ((current_base_row[196usize])
                            * ((next_base_row[33usize]) + (node_546))))
                        + ((current_base_row[197usize])
                            * ((next_base_row[34usize]) + (node_546))))
                        + ((current_base_row[198usize])
                            * ((next_base_row[35usize]) + (node_546))))
                        + ((current_base_row[199usize])
                            * ((next_base_row[36usize]) + (node_546))))))
                + ((current_base_row[224usize])
                    * ((((((current_base_row[195usize]) * (node_1238))
                        + ((current_base_row[196usize])
                            * ((next_base_row[31usize]) + (node_550))))
                        + ((current_base_row[197usize]) * (node_1591)))
                        + ((current_base_row[198usize])
                            * ((next_base_row[31usize]) + (node_554))))
                        + ((current_base_row[199usize]) * (node_1665)))))
                + ((current_base_row[228usize]) * (node_516)))
                + ((current_base_row[229usize]) * (node_516)))
                + ((current_base_row[235usize]) * (node_262)))
                + ((current_base_row[237usize]) * (node_1182)))
                + ((current_base_row[234usize]) * (node_520)))
                + ((current_base_row[238usize]) * (node_520)))
                + ((current_base_row[243usize]) * (node_520)))
                + ((current_base_row[250usize]) * (node_520)))
                + ((current_base_row[268usize]) * (node_524)))
                + ((current_base_row[269usize]) * (node_524)))
                + ((current_base_row[282usize]) * (node_516))) * (node_3926),
            ((((((((((((((((current_base_row[205usize]) * (node_516))
                + ((current_base_row[206usize]) * (node_553)))
                + ((current_base_row[213usize]) * (node_1239)))
                + ((current_base_row[223usize]) * (node_516)))
                + ((current_base_row[218usize])
                    * ((((((current_base_row[195usize]) * (node_549))
                        + ((current_base_row[196usize])
                            * ((next_base_row[34usize]) + (node_548))))
                        + ((current_base_row[197usize])
                            * ((next_base_row[35usize]) + (node_548))))
                        + ((current_base_row[198usize])
                            * ((next_base_row[36usize]) + (node_548))))
                        + ((current_base_row[199usize])
                            * ((next_base_row[37usize]) + (node_548))))))
                + ((current_base_row[224usize])
                    * ((((((current_base_row[195usize]) * (node_1239))
                        + ((current_base_row[196usize])
                            * ((next_base_row[32usize]) + (node_552))))
                        + ((current_base_row[197usize]) * (node_1592)))
                        + ((current_base_row[198usize])
                            * ((next_base_row[32usize]) + (node_556))))
                        + ((current_base_row[199usize]) * (node_1666)))))
                + ((current_base_row[228usize]) * (node_520)))
                + ((current_base_row[229usize]) * (node_520)))
                + ((current_base_row[235usize]) * (node_286)))
                + ((current_base_row[237usize]) * (node_516)))
                + ((current_base_row[234usize]) * (node_524)))
                + ((current_base_row[238usize]) * (node_524)))
                + ((current_base_row[243usize]) * (node_524)))
                + ((current_base_row[250usize]) * (node_524)))
                + ((current_base_row[282usize]) * (node_520))) * (node_3926),
            ((((((((((((current_base_row[205usize]) * (node_520))
                + ((current_base_row[206usize]) * (node_555)))
                + ((current_base_row[213usize]) * (node_1240)))
                + ((current_base_row[223usize]) * (node_520)))
                + ((current_base_row[218usize])
                    * (((((current_base_row[195usize]) * (node_551))
                        + ((current_base_row[196usize])
                            * ((next_base_row[35usize]) + (node_550))))
                        + ((current_base_row[197usize])
                            * ((next_base_row[36usize]) + (node_550))))
                        + ((current_base_row[198usize])
                            * ((next_base_row[37usize]) + (node_550))))))
                + ((current_base_row[224usize])
                    * (((((current_base_row[195usize]) * (node_1240))
                        + ((current_base_row[196usize])
                            * ((next_base_row[33usize]) + (node_554))))
                        + ((current_base_row[197usize]) * (node_1593)))
                        + ((current_base_row[198usize])
                            * ((next_base_row[33usize]) + (node_854))))))
                + ((current_base_row[228usize]) * (node_524)))
                + ((current_base_row[229usize]) * (node_524)))
                + ((current_base_row[235usize]) * (node_516)))
                + ((current_base_row[237usize]) * (node_520)))
                + ((current_base_row[282usize]) * (node_524))) * (node_3926),
            (((((((((current_base_row[205usize]) * (node_524))
                + ((current_base_row[206usize]) * (node_557)))
                + ((current_base_row[213usize]) * (node_1241)))
                + ((current_base_row[223usize]) * (node_524)))
                + ((current_base_row[218usize])
                    * ((((current_base_row[195usize]) * (node_553))
                        + ((current_base_row[196usize])
                            * ((next_base_row[36usize]) + (node_552))))
                        + ((current_base_row[197usize])
                            * ((next_base_row[37usize]) + (node_552))))))
                + ((current_base_row[224usize])
                    * ((((current_base_row[195usize]) * (node_1241))
                        + ((current_base_row[196usize])
                            * ((next_base_row[34usize]) + (node_556))))
                        + ((current_base_row[197usize]) * (node_1594)))))
                + ((current_base_row[235usize]) * (node_520)))
                + ((current_base_row[237usize]) * (node_524))) * (node_3926),
            ((((((current_base_row[206usize]) * (node_558))
                + ((current_base_row[213usize]) * (node_1242)))
                + ((current_base_row[218usize])
                    * (((current_base_row[195usize]) * (node_555))
                        + ((current_base_row[196usize])
                            * ((next_base_row[37usize]) + (node_554))))))
                + ((current_base_row[224usize])
                    * (((current_base_row[195usize]) * (node_1242))
                        + ((current_base_row[196usize])
                            * ((next_base_row[35usize]) + (node_854))))))
                + ((current_base_row[235usize]) * (node_524))) * (node_3926),
            (((((current_base_row[206usize]) * (node_567))
                + ((current_base_row[213usize]) * (node_1243)))
                + ((current_base_row[218usize])
                    * ((current_base_row[195usize]) * (node_557))))
                + ((current_base_row[224usize])
                    * ((current_base_row[195usize]) * (node_1243)))) * (node_3926),
            (((((current_base_row[206usize]) * (node_516))
                + ((current_base_row[213usize]) * (node_262)))
                + ((current_base_row[218usize]) * (node_512)))
                + ((current_base_row[224usize]) * (node_512))) * (node_3926),
            (((((current_base_row[206usize]) * (node_520))
                + ((current_base_row[213usize]) * (node_286)))
                + ((current_base_row[218usize]) * (node_520)))
                + ((current_base_row[224usize]) * (node_520))) * (node_3926),
            (((((current_base_row[206usize]) * (node_524))
                + ((current_base_row[213usize]) * (node_516)))
                + ((current_base_row[218usize]) * (node_524)))
                + ((current_base_row[224usize]) * (node_524))) * (node_3926),
            ((current_base_row[213usize]) * (node_520)) * (node_3926),
            ((current_base_row[213usize]) * (node_524)) * (node_3926),
            (((next_ext_row[13usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (current_ext_row[13usize])))
                * ((challenges[11usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (next_base_row[7usize]))))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (next_base_row[45usize])),
            ((node_3926)
                * (((node_4002)
                    * ((challenges[3usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * ((((challenges[13usize]) * (next_base_row[9usize]))
                                + ((challenges[14usize]) * (next_base_row[10usize])))
                                + ((challenges[15usize]) * (next_base_row[11usize]))))))
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                + ((next_base_row[8usize]) * (node_4002)),
            (next_ext_row[8usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_ext_row[8usize])
                        * ((challenges[9usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * ((((((challenges[24usize]) * (next_base_row[7usize]))
                                    + ((challenges[25usize]) * (next_base_row[10usize])))
                                    + ((challenges[26usize]) * (next_base_row[19usize])))
                                    + ((challenges[27usize]) * (next_base_row[20usize])))
                                    + ((challenges[28usize]) * (next_base_row[21usize]))))))),
            (((((((next_base_row[10usize])
                + (BFieldElement::from_raw_u64(18446743992105173011u64)))
                * ((next_base_row[10usize])
                    + (BFieldElement::from_raw_u64(18446743914795761701u64))))
                * ((next_base_row[10usize])
                    + (BFieldElement::from_raw_u64(18446743880436023341u64))))
                * ((next_ext_row[9usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_ext_row[9usize]))))
                + ((current_base_row[352usize]) * ((node_4138) + (node_4139))))
                + (((current_base_row[353usize]) * (node_4048)) * (node_4144)))
                + (((current_base_row[355usize]) * (node_4048)) * (node_4144)),
            (((((current_base_row[10usize])
                + (BFieldElement::from_raw_u64(18446743992105173011u64)))
                * ((current_base_row[10usize])
                    + (BFieldElement::from_raw_u64(18446743914795761701u64))))
                * ((current_base_row[10usize])
                    + (BFieldElement::from_raw_u64(18446743880436023341u64))))
                * ((next_ext_row[10usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_ext_row[10usize]))))
                + ((((current_base_row[230usize]) + (current_base_row[298usize]))
                    + (current_base_row[297usize]))
                    * (((next_ext_row[10usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * ((challenges[5usize]) * (current_ext_row[10usize]))))
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (node_198)))),
            (((((current_base_row[330usize])
                * ((next_ext_row[11usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_ext_row[11usize]))))
                + ((current_base_row[257usize]) * (node_4193)))
                + ((current_base_row[258usize])
                    * ((node_4193)
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (node_615)))))
                + ((current_base_row[260usize])
                    * (((node_4189)
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * ((challenges[31usize])
                                * (BFieldElement::from_raw_u64(146028888030u64)))))
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((((((node_574)
                                + ((challenges[36usize]) * (current_base_row[39usize])))
                                + ((challenges[37usize]) * (current_base_row[40usize])))
                                + ((challenges[38usize]) * (current_base_row[41usize])))
                                + ((challenges[39usize]) * (current_base_row[42usize])))
                                + ((challenges[40usize]) * (current_base_row[43usize])))
                                + ((challenges[41usize]) * (current_base_row[44usize])))))))
                + ((current_base_row[262usize]) * ((node_4193) + (node_4139))),
            (((((((((((current_base_row[237usize])
                * (((node_4282) * (((node_4232) + (node_4235)) + (node_4239)))
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                + ((current_base_row[234usize]) * (node_4286)))
                + ((current_base_row[238usize]) * (node_4286)))
                + ((current_base_row[243usize])
                    * (((node_4282)
                        * (((node_4246)
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * ((challenges[57usize])
                                    * (BFieldElement::from_raw_u64(60129542130u64)))))
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((challenges[58usize])
                                    * (((current_base_row[22usize])
                                        + (current_base_row[23usize])) + (node_1937)))
                                    * (BFieldElement::from_raw_u64(9223372036854775808u64))))))
                        + (BFieldElement::from_raw_u64(18446744065119617026u64)))))
                + ((current_base_row[250usize]) * (node_4286)))
                + ((current_base_row[270usize]) * (node_4290)))
                + ((current_base_row[266usize])
                    * (((((node_4282) * (node_4269)) * (node_4273))
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (node_4269)))
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (node_4273)))))
                + ((current_base_row[273usize]) * (node_4290)))
                + ((current_base_row[298usize]) * (node_4292)))
                + ((current_base_row[297usize]) * (node_4292)))
                + (((BFieldElement::from_raw_u64(4294967295u64))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_base_row[14usize]))) * (node_4282)),
            (((next_ext_row[14usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_ext_row[14usize])
                        * ((challenges[7usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((((challenges[16usize]) * (next_base_row[46usize]))
                                    + ((challenges[17usize]) * (next_base_row[47usize])))
                                    + ((challenges[18usize]) * (next_base_row[48usize])))
                                    + ((challenges[19usize]) * (next_base_row[49usize]))))))))
                * (node_4342))
                + (((next_ext_row[14usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_ext_row[14usize]))) * (node_4359)),
            ((((((node_4368)
                * ((challenges[11usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((next_base_row[46usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (current_base_row[46usize]))))))
                + (BFieldElement::from_raw_u64(18446744065119617026u64))) * (node_4336))
                * (node_4342)) + ((node_4368) * (node_4335)))
                + ((node_4368) * (node_4359)),
            ((node_4410)
                * ((next_ext_row[16usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((current_ext_row[16usize]) * (node_4428)))))
                + ((node_4413) * ((next_ext_row[16usize]) + (node_4433))),
            ((node_4410)
                * (((next_ext_row[17usize]) + (node_4433))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((node_4428) * (current_ext_row[17usize])))))
                + ((node_4413)
                    * ((next_ext_row[17usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (current_ext_row[17usize])))),
            ((node_4410)
                * (((next_ext_row[18usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((challenges[12usize]) * (current_ext_row[18usize]))))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (next_base_row[55usize]))))
                + ((node_4413)
                    * ((next_ext_row[18usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (current_ext_row[18usize])))),
            ((node_4410)
                * (((next_ext_row[19usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((challenges[12usize]) * (current_ext_row[19usize]))))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (next_base_row[56usize]))))
                + ((node_4413)
                    * ((next_ext_row[19usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (current_ext_row[19usize])))),
            (((next_ext_row[20usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_ext_row[20usize])
                        * ((challenges[8usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((((next_base_row[50usize]) * (challenges[20usize]))
                                    + ((next_base_row[52usize]) * (challenges[21usize])))
                                    + ((next_base_row[53usize]) * (challenges[22usize])))
                                    + ((next_base_row[51usize]) * (challenges[23usize]))))))))
                * (node_4405))
                + (((next_ext_row[20usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (current_ext_row[20usize]))) * (node_4479)),
            (((current_ext_row[84usize]) * (node_4405)) + ((node_4488) * (node_4410)))
                + ((node_4488) * (node_4479)),
            (next_ext_row[22usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_ext_row[22usize])
                        * ((challenges[9usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * ((((((challenges[24usize]) * (next_base_row[57usize]))
                                    + ((challenges[25usize]) * (next_base_row[58usize])))
                                    + ((challenges[26usize]) * (next_base_row[59usize])))
                                    + ((challenges[27usize]) * (next_base_row[60usize])))
                                    + ((challenges[28usize]) * (next_base_row[61usize]))))))),
            ((node_4517)
                * (((node_4553)
                    * ((challenges[11usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (node_4532))))
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                + ((node_4516) * (node_4553)),
            (((current_base_row[356usize])
                * (((next_ext_row[24usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((challenges[30usize]) * (current_ext_row[24usize]))))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((((((((((((((((((((challenges[29usize]) + (node_5306))
                            * (challenges[29usize])) + (node_5317))
                            * (challenges[29usize])) + (node_5328))
                            * (challenges[29usize])) + (node_5339))
                            * (challenges[29usize])) + (next_base_row[97usize]))
                            * (challenges[29usize])) + (next_base_row[98usize]))
                            * (challenges[29usize])) + (next_base_row[99usize]))
                            * (challenges[29usize])) + (next_base_row[100usize]))
                            * (challenges[29usize])) + (next_base_row[101usize]))
                            * (challenges[29usize])) + (next_base_row[102usize])))))
                + ((next_base_row[64usize]) * (node_5642)))
                + ((node_5430) * (node_5642)),
            ((current_base_row[357usize]) * (node_5430))
                * (((((((((((challenges[0usize]) + (node_4590)) * (challenges[0usize]))
                    + (node_4601)) * (challenges[0usize])) + (node_4612))
                    * (challenges[0usize])) + (node_4623)) * (challenges[0usize]))
                    + (current_base_row[97usize]))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (challenges[62usize]))),
            (current_base_row[371usize])
                * ((((((node_5473) + (node_5474)) + (node_5476)) + (node_5478))
                    + (node_5480)) + (node_5482)),
            (current_base_row[372usize])
                * (((((((((((((((((challenges[32usize])
                    * ((node_5306)
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (node_4590))))
                    + ((challenges[33usize])
                        * ((node_5317)
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (node_4601)))))
                    + ((challenges[34usize])
                        * ((node_5328)
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (node_4612)))))
                    + ((challenges[35usize])
                        * ((node_5339)
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (node_4623)))))
                    + ((challenges[36usize])
                        * ((next_base_row[97usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (current_base_row[97usize])))))
                    + ((challenges[37usize])
                        * ((next_base_row[98usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (current_base_row[98usize])))))
                    + ((challenges[38usize])
                        * ((next_base_row[99usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (current_base_row[99usize])))))
                    + ((challenges[39usize])
                        * ((next_base_row[100usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (current_base_row[100usize])))))
                    + ((challenges[40usize])
                        * ((next_base_row[101usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (current_base_row[101usize])))))
                    + ((challenges[41usize])
                        * ((next_base_row[102usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (current_base_row[102usize]))))) + (node_5473))
                    + (node_5474)) + (node_5476)) + (node_5478)) + (node_5480))
                    + (node_5482)),
            ((((current_base_row[320usize]) * (current_base_row[326usize]))
                * (((next_ext_row[25usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((challenges[4usize]) * (current_ext_row[25usize]))))
                    + (node_5572))) + ((next_base_row[64usize]) * (node_5549)))
                + ((node_5435) * (node_5549)),
            ((((node_5592) * (current_base_row[326usize]))
                * (((next_ext_row[26usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((challenges[5usize]) * (current_ext_row[26usize]))))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (node_5558)))) + ((node_5491) * (node_5583)))
                + ((node_5435) * (node_5583)),
            ((((current_base_row[320usize]) * (node_5542))
                * ((((next_ext_row[27usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((challenges[6usize]) * (current_ext_row[27usize]))))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((challenges[31usize]) * (next_base_row[63usize]))))
                    + (node_5572))) + ((next_base_row[64usize]) * (node_5609)))
                + ((((node_5439) * (node_5544)) * (node_5612)) * (node_5609)),
            (((current_base_row[296usize])
                * (((node_5661)
                    * ((challenges[48usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((challenges[49usize]) * (next_base_row[65usize]))
                                + ((challenges[50usize]) * (next_base_row[81usize]))))))
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                + ((node_5592) * (node_5661))) + ((node_5669) * (node_5661)),
            (((current_base_row[296usize])
                * (((node_5682)
                    * ((challenges[48usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((challenges[49usize]) * (next_base_row[66usize]))
                                + ((challenges[50usize]) * (next_base_row[82usize]))))))
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                + ((node_5592) * (node_5682))) + ((node_5669) * (node_5682)),
            (((current_base_row[296usize])
                * (((node_5699)
                    * ((challenges[48usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((challenges[49usize]) * (next_base_row[67usize]))
                                + ((challenges[50usize]) * (next_base_row[83usize]))))))
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                + ((node_5592) * (node_5699))) + ((node_5669) * (node_5699)),
            (((current_base_row[296usize])
                * (((node_5716)
                    * ((challenges[48usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((challenges[49usize]) * (next_base_row[68usize]))
                                + ((challenges[50usize]) * (next_base_row[84usize]))))))
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                + ((node_5592) * (node_5716))) + ((node_5669) * (node_5716)),
            (((current_base_row[296usize])
                * (((node_5733)
                    * ((challenges[48usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((challenges[49usize]) * (next_base_row[69usize]))
                                + ((challenges[50usize]) * (next_base_row[85usize]))))))
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                + ((node_5592) * (node_5733))) + ((node_5669) * (node_5733)),
            (((current_base_row[296usize])
                * (((node_5750)
                    * ((challenges[48usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((challenges[49usize]) * (next_base_row[70usize]))
                                + ((challenges[50usize]) * (next_base_row[86usize]))))))
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                + ((node_5592) * (node_5750))) + ((node_5669) * (node_5750)),
            (((current_base_row[296usize])
                * (((node_5767)
                    * ((challenges[48usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((challenges[49usize]) * (next_base_row[71usize]))
                                + ((challenges[50usize]) * (next_base_row[87usize]))))))
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                + ((node_5592) * (node_5767))) + ((node_5669) * (node_5767)),
            (((current_base_row[296usize])
                * (((node_5784)
                    * ((challenges[48usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((challenges[49usize]) * (next_base_row[72usize]))
                                + ((challenges[50usize]) * (next_base_row[88usize]))))))
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                + ((node_5592) * (node_5784))) + ((node_5669) * (node_5784)),
            (((current_base_row[296usize])
                * (((node_5801)
                    * ((challenges[48usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((challenges[49usize]) * (next_base_row[73usize]))
                                + ((challenges[50usize]) * (next_base_row[89usize]))))))
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                + ((node_5592) * (node_5801))) + ((node_5669) * (node_5801)),
            (((current_base_row[296usize])
                * (((node_5818)
                    * ((challenges[48usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((challenges[49usize]) * (next_base_row[74usize]))
                                + ((challenges[50usize]) * (next_base_row[90usize]))))))
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                + ((node_5592) * (node_5818))) + ((node_5669) * (node_5818)),
            (((current_base_row[296usize])
                * (((node_5835)
                    * ((challenges[48usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((challenges[49usize]) * (next_base_row[75usize]))
                                + ((challenges[50usize]) * (next_base_row[91usize]))))))
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                + ((node_5592) * (node_5835))) + ((node_5669) * (node_5835)),
            (((current_base_row[296usize])
                * (((node_5852)
                    * ((challenges[48usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((challenges[49usize]) * (next_base_row[76usize]))
                                + ((challenges[50usize]) * (next_base_row[92usize]))))))
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                + ((node_5592) * (node_5852))) + ((node_5669) * (node_5852)),
            (((current_base_row[296usize])
                * (((node_5869)
                    * ((challenges[48usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((challenges[49usize]) * (next_base_row[77usize]))
                                + ((challenges[50usize]) * (next_base_row[93usize]))))))
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                + ((node_5592) * (node_5869))) + ((node_5669) * (node_5869)),
            (((current_base_row[296usize])
                * (((node_5886)
                    * ((challenges[48usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((challenges[49usize]) * (next_base_row[78usize]))
                                + ((challenges[50usize]) * (next_base_row[94usize]))))))
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                + ((node_5592) * (node_5886))) + ((node_5669) * (node_5886)),
            (((current_base_row[296usize])
                * (((node_5903)
                    * ((challenges[48usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((challenges[49usize]) * (next_base_row[79usize]))
                                + ((challenges[50usize]) * (next_base_row[95usize]))))))
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                + ((node_5592) * (node_5903))) + ((node_5669) * (node_5903)),
            (((current_base_row[296usize])
                * (((node_5920)
                    * ((challenges[48usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((challenges[49usize]) * (next_base_row[80usize]))
                                + ((challenges[50usize]) * (next_base_row[96usize]))))))
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))))
                + ((node_5592) * (node_5920))) + ((node_5669) * (node_5920)),
            ((node_5946)
                * (((node_5956)
                    * ((challenges[48usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((challenges[49usize])
                                * (((BFieldElement::from_raw_u64(1099511627520u64))
                                    * (next_base_row[130usize])) + (next_base_row[131usize])))
                                + ((challenges[50usize])
                                    * (((BFieldElement::from_raw_u64(1099511627520u64))
                                        * (next_base_row[132usize]))
                                        + (next_base_row[133usize])))))))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (next_base_row[134usize]))))
                + ((next_base_row[129usize]) * (node_5956)),
            ((node_5946)
                * ((((((node_5972)
                    * ((challenges[51usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (node_5967))))
                    * ((challenges[51usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (node_5970))))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((BFieldElement::from_raw_u64(8589934590u64))
                            * (challenges[51usize])))) + (node_5967)) + (node_5970)))
                + ((next_base_row[129usize]) * (node_5972)),
            ((node_5998)
                * (((node_6010)
                    * ((challenges[51usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((next_base_row[136usize]) * (challenges[52usize]))
                                + ((next_base_row[137usize]) * (challenges[53usize]))))))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (next_base_row[138usize]))))
                + ((next_base_row[135usize]) * (node_6010)),
            ((node_5998)
                * (((next_ext_row[47usize])
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * ((current_ext_row[47usize]) * (challenges[54usize]))))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (next_base_row[137usize]))))
                + ((next_base_row[135usize])
                    * ((next_ext_row[47usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (current_ext_row[47usize])))),
            (node_6058) * (node_6174),
            (next_base_row[139usize])
                * (((node_6174)
                    * ((challenges[10usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((((challenges[57usize]) * (next_base_row[142usize]))
                                + ((challenges[55usize]) * (next_base_row[143usize])))
                                + ((challenges[56usize]) * (next_base_row[145usize])))
                                + ((challenges[58usize]) * (next_base_row[147usize]))))))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (next_base_row[148usize]))),
            (current_ext_row[50usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_281)
                        * ((challenges[7usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_272)
                                    + ((challenges[18usize])
                                        * ((next_base_row[38usize])
                                            + (BFieldElement::from_raw_u64(4294967295u64)))))
                                    + ((challenges[19usize]) * (next_base_row[36usize]))))))),
            (current_ext_row[51usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_564)
                        * ((challenges[7usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_272)
                                    + ((challenges[18usize])
                                        * ((current_base_row[38usize])
                                            + (BFieldElement::from_raw_u64(4294967295u64)))))
                                    + ((challenges[19usize])
                                        * (current_base_row[36usize]))))))),
            (current_ext_row[52usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_ext_row[50usize])
                        * ((challenges[7usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_272)
                                    + ((challenges[18usize])
                                        * ((next_base_row[38usize])
                                            + (BFieldElement::from_raw_u64(8589934590u64)))))
                                    + ((challenges[19usize]) * (next_base_row[35usize]))))))),
            (current_ext_row[53usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_ext_row[51usize])
                        * ((challenges[7usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_272)
                                    + ((challenges[18usize])
                                        * ((current_base_row[38usize])
                                            + (BFieldElement::from_raw_u64(8589934590u64)))))
                                    + ((challenges[19usize])
                                        * (current_base_row[35usize]))))))),
            (current_ext_row[54usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_ext_row[52usize])
                        * ((challenges[7usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_272)
                                    + ((challenges[18usize])
                                        * ((next_base_row[38usize])
                                            + (BFieldElement::from_raw_u64(12884901885u64)))))
                                    + ((challenges[19usize]) * (next_base_row[34usize]))))))),
            (current_ext_row[55usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_ext_row[53usize])
                        * ((challenges[7usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_272)
                                    + ((challenges[18usize])
                                        * ((current_base_row[38usize])
                                            + (BFieldElement::from_raw_u64(12884901885u64)))))
                                    + ((challenges[19usize])
                                        * (current_base_row[34usize]))))))),
            (current_ext_row[56usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_ext_row[54usize])
                        * ((challenges[7usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_272)
                                    + ((challenges[18usize])
                                        * ((next_base_row[38usize])
                                            + (BFieldElement::from_raw_u64(17179869180u64)))))
                                    + ((challenges[19usize]) * (next_base_row[33usize]))))))),
            (current_ext_row[57usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_1283)
                        * ((challenges[8usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_1274)
                                    + (((next_base_row[22usize])
                                        + (BFieldElement::from_raw_u64(8589934590u64)))
                                        * (challenges[21usize])))
                                    + ((next_base_row[24usize]) * (challenges[22usize]))))))),
            (current_ext_row[58usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((node_1511)
                        * ((challenges[8usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_1272) + (node_1533))
                                    + ((current_base_row[24usize])
                                        * (challenges[22usize]))))))),
            (current_ext_row[59usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_ext_row[6usize]) * (current_ext_row[56usize]))),
            (current_ext_row[60usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_ext_row[55usize])
                        * ((challenges[7usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_272)
                                    + ((challenges[18usize])
                                        * ((current_base_row[38usize])
                                            + (BFieldElement::from_raw_u64(17179869180u64)))))
                                    + ((challenges[19usize])
                                        * (current_base_row[33usize]))))))),
            (current_ext_row[61usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_ext_row[57usize])
                        * ((challenges[8usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_1274)
                                    + (((next_base_row[22usize])
                                        + (BFieldElement::from_raw_u64(12884901885u64)))
                                        * (challenges[21usize])))
                                    + ((next_base_row[25usize]) * (challenges[22usize]))))))),
            (current_ext_row[62usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_ext_row[58usize])
                        * ((challenges[8usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_1272) + (node_1573))
                                    + ((current_base_row[25usize])
                                        * (challenges[22usize]))))))),
            (current_ext_row[63usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_ext_row[61usize])
                        * ((challenges[8usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_1274)
                                    + (((next_base_row[22usize])
                                        + (BFieldElement::from_raw_u64(17179869180u64)))
                                        * (challenges[21usize])))
                                    + ((next_base_row[26usize]) * (challenges[22usize]))))))),
            (current_ext_row[64usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_ext_row[62usize])
                        * ((challenges[8usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_1272)
                                    + (((current_base_row[22usize])
                                        + (BFieldElement::from_raw_u64(12884901885u64)))
                                        * (challenges[21usize])))
                                    + ((current_base_row[26usize])
                                        * (challenges[22usize]))))))),
            (current_ext_row[65usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_ext_row[56usize])
                        * ((challenges[7usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_272)
                                    + ((challenges[18usize])
                                        * ((next_base_row[38usize])
                                            + (BFieldElement::from_raw_u64(21474836475u64)))))
                                    + ((challenges[19usize]) * (next_base_row[32usize]))))))
                        * ((challenges[7usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_272)
                                    + ((challenges[18usize])
                                        * ((next_base_row[38usize])
                                            + (BFieldElement::from_raw_u64(25769803770u64)))))
                                    + ((challenges[19usize]) * (next_base_row[31usize]))))))
                        * ((challenges[7usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_272)
                                    + ((challenges[18usize])
                                        * ((next_base_row[38usize])
                                            + (BFieldElement::from_raw_u64(30064771065u64)))))
                                    + ((challenges[19usize]) * (next_base_row[30usize]))))))),
            (current_ext_row[66usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((current_ext_row[60usize])
                        * ((challenges[7usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_272)
                                    + ((challenges[18usize])
                                        * ((current_base_row[38usize])
                                            + (BFieldElement::from_raw_u64(21474836475u64)))))
                                    + ((challenges[19usize]) * (current_base_row[32usize]))))))
                        * ((challenges[7usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_272)
                                    + ((challenges[18usize])
                                        * ((current_base_row[38usize])
                                            + (BFieldElement::from_raw_u64(25769803770u64)))))
                                    + ((challenges[19usize]) * (current_base_row[31usize]))))))
                        * ((challenges[7usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_272)
                                    + ((challenges[18usize])
                                        * ((current_base_row[38usize])
                                            + (BFieldElement::from_raw_u64(30064771065u64)))))
                                    + ((challenges[19usize])
                                        * (current_base_row[30usize]))))))),
            (current_ext_row[67usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_ext_row[6usize])
                        * (((current_ext_row[65usize])
                            * ((challenges[7usize])
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (((node_272)
                                        + ((challenges[18usize])
                                            * ((next_base_row[38usize])
                                                + (BFieldElement::from_raw_u64(34359738360u64)))))
                                        + ((challenges[19usize]) * (next_base_row[29usize]))))))
                            * ((challenges[7usize])
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (((node_272)
                                        + ((challenges[18usize])
                                            * ((next_base_row[38usize])
                                                + (BFieldElement::from_raw_u64(38654705655u64)))))
                                        + ((challenges[19usize]) * (next_base_row[28usize])))))))),
            (current_ext_row[68usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_ext_row[6usize])
                        * (((current_ext_row[66usize])
                            * ((challenges[7usize])
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (((node_272)
                                        + ((challenges[18usize])
                                            * ((current_base_row[38usize])
                                                + (BFieldElement::from_raw_u64(34359738360u64)))))
                                        + ((challenges[19usize]) * (current_base_row[29usize]))))))
                            * ((challenges[7usize])
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * (((node_272)
                                        + ((challenges[18usize])
                                            * ((current_base_row[38usize])
                                                + (BFieldElement::from_raw_u64(38654705655u64)))))
                                        + ((challenges[19usize])
                                            * (current_base_row[28usize])))))))),
            (current_ext_row[69usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[199usize])
                        * ((next_ext_row[7usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * ((current_ext_row[7usize])
                                    * ((current_ext_row[63usize])
                                        * ((challenges[8usize])
                                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                                * (((node_1274)
                                                    + (((next_base_row[22usize])
                                                        + (BFieldElement::from_raw_u64(21474836475u64)))
                                                        * (challenges[21usize])))
                                                    + ((next_base_row[27usize])
                                                        * (challenges[22usize]))))))))))),
            (current_ext_row[70usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[199usize])
                        * ((next_ext_row[7usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * ((current_ext_row[7usize])
                                    * ((current_ext_row[64usize])
                                        * ((challenges[8usize])
                                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                                * (((node_1272)
                                                    + (((current_base_row[22usize])
                                                        + (BFieldElement::from_raw_u64(17179869180u64)))
                                                        * (challenges[21usize])))
                                                    + ((current_base_row[27usize])
                                                        * (challenges[22usize]))))))))))),
            (current_ext_row[71usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (((((challenges[8usize])
                        + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                            * (((node_1274)
                                + ((current_base_row[29usize]) * (challenges[21usize])))
                                + (node_2153))))
                        * ((challenges[8usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_1274)
                                    + (((current_base_row[29usize])
                                        + (BFieldElement::from_raw_u64(4294967295u64)))
                                        * (challenges[21usize]))) + (node_2159)))))
                        * ((challenges[8usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_1274)
                                    + (((current_base_row[29usize])
                                        + (BFieldElement::from_raw_u64(8589934590u64)))
                                        * (challenges[21usize]))) + (node_2166)))))
                        * ((challenges[8usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_1274)
                                    + (((current_base_row[29usize])
                                        + (BFieldElement::from_raw_u64(12884901885u64)))
                                        * (challenges[21usize]))) + (node_2173)))))),
            (current_ext_row[72usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((node_2216)
                        * ((challenges[8usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_1274) + (node_1533)) + (node_2159)))))
                        * ((challenges[8usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * (((node_1274) + (node_1573)) + (node_2166)))))
                        * ((challenges[8usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * ((node_2228) + (node_2173)))))),
            (current_ext_row[73usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((node_2216)
                        * ((challenges[8usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * ((node_2228) + (node_2159)))))
                        * ((challenges[8usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * ((node_2234) + (node_2166)))))
                        * ((challenges[8usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * ((node_2240) + (node_2173)))))),
            (current_ext_row[74usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[195usize]) * (node_286))),
            (current_ext_row[75usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[196usize])
                        * ((next_ext_row[6usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * ((current_ext_row[6usize])
                                    * (current_ext_row[50usize])))))),
            (current_ext_row[76usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[197usize]) * (node_385))),
            (current_ext_row[77usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[198usize])
                        * ((next_ext_row[6usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * ((current_ext_row[6usize])
                                    * (current_ext_row[54usize])))))),
            (current_ext_row[78usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[195usize]) * (node_567))),
            (current_ext_row[79usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[196usize])
                        * ((next_ext_row[6usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * ((current_ext_row[6usize])
                                    * (current_ext_row[51usize])))))),
            (current_ext_row[80usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[197usize])
                        * ((next_ext_row[6usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * ((current_ext_row[6usize])
                                    * (current_ext_row[53usize])))))),
            (current_ext_row[81usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[198usize])
                        * ((next_ext_row[6usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * ((current_ext_row[6usize])
                                    * (current_ext_row[55usize])))))),
            (current_ext_row[82usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[199usize])
                        * ((next_ext_row[6usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * ((current_ext_row[6usize])
                                    * (current_ext_row[60usize])))))),
            (current_ext_row[83usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_ext_row[7usize])
                        * (((current_ext_row[72usize])
                            * ((challenges[8usize])
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * ((node_2234) + (node_2180)))))
                            * ((challenges[8usize])
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * ((node_2240)
                                        + ((current_base_row[44usize])
                                            * (challenges[22usize])))))))),
            (current_ext_row[84usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((((node_4488)
                        * ((challenges[11usize])
                            + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                * ((next_base_row[50usize])
                                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                        * (current_base_row[50usize]))))))
                        + (BFieldElement::from_raw_u64(18446744065119617026u64)))
                        * (node_4413))),
            (current_ext_row[85usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[297usize])
                        * (((current_ext_row[7usize])
                            * ((current_ext_row[71usize])
                                * ((challenges[8usize])
                                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                        * (((node_1274)
                                            + (((current_base_row[29usize])
                                                + (BFieldElement::from_raw_u64(17179869180u64)))
                                                * (challenges[21usize]))) + (node_2180))))))
                            + (node_2186)))),
            (current_ext_row[86usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[218usize])
                        * ((((((current_base_row[195usize])
                            * ((next_ext_row[7usize])
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * ((current_ext_row[7usize]) * (node_1283)))))
                            + ((current_base_row[196usize])
                                * ((next_ext_row[7usize])
                                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                        * ((current_ext_row[7usize])
                                            * (current_ext_row[57usize]))))))
                            + ((current_base_row[197usize])
                                * ((next_ext_row[7usize])
                                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                        * ((current_ext_row[7usize])
                                            * (current_ext_row[61usize]))))))
                            + ((current_base_row[198usize])
                                * ((next_ext_row[7usize])
                                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                        * ((current_ext_row[7usize])
                                            * (current_ext_row[63usize]))))))
                            + (current_ext_row[69usize])))),
            (current_ext_row[87usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * ((current_base_row[224usize])
                        * ((((((current_base_row[195usize])
                            * ((next_ext_row[7usize])
                                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                    * ((current_ext_row[7usize]) * (node_1511)))))
                            + ((current_base_row[196usize])
                                * ((next_ext_row[7usize])
                                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                        * ((current_ext_row[7usize])
                                            * (current_ext_row[58usize]))))))
                            + ((current_base_row[197usize])
                                * ((next_ext_row[7usize])
                                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                        * ((current_ext_row[7usize])
                                            * (current_ext_row[62usize]))))))
                            + ((current_base_row[198usize])
                                * ((next_ext_row[7usize])
                                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                                        * ((current_ext_row[7usize])
                                            * (current_ext_row[64usize]))))))
                            + (current_ext_row[70usize])))),
        ];
        base_constraints.into_iter().chain(ext_constraints).collect()
    }
    #[allow(unused_variables)]
    fn evaluate_terminal_constraints(
        base_row: ArrayView1<XFieldElement>,
        ext_row: ArrayView1<XFieldElement>,
        challenges: &Challenges,
    ) -> Vec<XFieldElement> {
        let base_constraints = [
            (base_row[5usize]) + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((base_row[3usize]) + (BFieldElement::from_raw_u64(18446744030759878666u64)))
                * ((base_row[6usize])
                    + (BFieldElement::from_raw_u64(18446744065119617026u64))),
            base_row[10usize],
            ((base_row[62usize])
                * ((base_row[63usize])
                    + (BFieldElement::from_raw_u64(18446743897615892521u64))))
                * ((base_row[64usize])
                    + (BFieldElement::from_raw_u64(18446744047939747846u64))),
            (base_row[143usize])
                * ((base_row[142usize])
                    + (BFieldElement::from_raw_u64(18446743940565565471u64))),
            base_row[145usize],
        ];
        let ext_constraints = [
            (((ext_row[18usize]) * (ext_row[16usize]))
                + ((ext_row[19usize]) * (ext_row[17usize])))
                + (BFieldElement::from_raw_u64(18446744065119617026u64)),
            ((((base_row[62usize])
                + (BFieldElement::from_raw_u64(18446744060824649731u64)))
                * ((base_row[62usize])
                    + (BFieldElement::from_raw_u64(18446744056529682436u64))))
                * (base_row[62usize]))
                * (((((((((((challenges[0usize])
                    + ((((((base_row[65usize])
                        * (BFieldElement::from_raw_u64(18446744069414518785u64)))
                        + ((base_row[66usize])
                            * (BFieldElement::from_raw_u64(18446744069414584320u64))))
                        + ((base_row[67usize])
                            * (BFieldElement::from_raw_u64(281474976645120u64))))
                        + (base_row[68usize])) * (BFieldElement::from_raw_u64(1u64))))
                    * (challenges[0usize]))
                    + ((((((base_row[69usize])
                        * (BFieldElement::from_raw_u64(18446744069414518785u64)))
                        + ((base_row[70usize])
                            * (BFieldElement::from_raw_u64(18446744069414584320u64))))
                        + ((base_row[71usize])
                            * (BFieldElement::from_raw_u64(281474976645120u64))))
                        + (base_row[72usize])) * (BFieldElement::from_raw_u64(1u64))))
                    * (challenges[0usize]))
                    + ((((((base_row[73usize])
                        * (BFieldElement::from_raw_u64(18446744069414518785u64)))
                        + ((base_row[74usize])
                            * (BFieldElement::from_raw_u64(18446744069414584320u64))))
                        + ((base_row[75usize])
                            * (BFieldElement::from_raw_u64(281474976645120u64))))
                        + (base_row[76usize])) * (BFieldElement::from_raw_u64(1u64))))
                    * (challenges[0usize]))
                    + ((((((base_row[77usize])
                        * (BFieldElement::from_raw_u64(18446744069414518785u64)))
                        + ((base_row[78usize])
                            * (BFieldElement::from_raw_u64(18446744069414584320u64))))
                        + ((base_row[79usize])
                            * (BFieldElement::from_raw_u64(281474976645120u64))))
                        + (base_row[80usize])) * (BFieldElement::from_raw_u64(1u64))))
                    * (challenges[0usize])) + (base_row[97usize]))
                    + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                        * (challenges[62usize]))),
            (ext_row[47usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (challenges[61usize])),
            (ext_row[2usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[24usize])),
            (challenges[59usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[3usize])),
            (ext_row[4usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (challenges[60usize])),
            (ext_row[5usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[0usize])),
            (ext_row[6usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[14usize])),
            (ext_row[7usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[20usize])),
            (ext_row[8usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[22usize])),
            (ext_row[9usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[25usize])),
            (ext_row[26usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[10usize])),
            (ext_row[11usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[27usize])),
            ((((((((((((((((ext_row[44usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[28usize])))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[29usize])))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[30usize])))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[31usize])))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[32usize])))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[33usize])))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[34usize])))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[35usize])))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[36usize])))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[37usize])))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[38usize])))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[39usize])))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[40usize])))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[41usize])))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[42usize])))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[43usize])),
            (ext_row[45usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[46usize])),
            (ext_row[12usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[48usize])),
            (((ext_row[13usize])
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[15usize])))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[21usize])))
                + ((BFieldElement::from_raw_u64(18446744065119617026u64))
                    * (ext_row[23usize])),
        ];
        base_constraints.into_iter().chain(ext_constraints).collect()
    }
}
impl Quotientable for MasterExtTable {
    const NUM_INITIAL_CONSTRAINTS: usize = 81usize;
    const NUM_CONSISTENCY_CONSTRAINTS: usize = 94usize;
    const NUM_TRANSITION_CONSTRAINTS: usize = 394usize;
    const NUM_TERMINAL_CONSTRAINTS: usize = 23usize;
    #[allow(unused_variables)]
    fn initial_quotient_degree_bounds(interpolant_degree: isize) -> Vec<isize> {
        let zerofier_degree = 1;
        [
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
        ]
            .to_vec()
    }
    #[allow(unused_variables)]
    fn consistency_quotient_degree_bounds(
        interpolant_degree: isize,
        padded_height: usize,
    ) -> Vec<isize> {
        let zerofier_degree = padded_height as isize;
        [
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
        ]
            .to_vec()
    }
    #[allow(unused_variables)]
    fn transition_quotient_degree_bounds(
        interpolant_degree: isize,
        padded_height: usize,
    ) -> Vec<isize> {
        let zerofier_degree = padded_height as isize - 1;
        [
            interpolant_degree - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
        ]
            .to_vec()
    }
    #[allow(unused_variables)]
    fn terminal_quotient_degree_bounds(interpolant_degree: isize) -> Vec<isize> {
        let zerofier_degree = 1;
        [
            interpolant_degree - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree * 3isize - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree * 2isize - zerofier_degree,
            interpolant_degree * 4isize - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
            interpolant_degree - zerofier_degree,
        ]
            .to_vec()
    }
}
