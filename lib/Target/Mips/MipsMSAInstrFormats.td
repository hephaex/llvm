//===- MipsMSAInstrFormats.td - Mips Instruction Formats ---*- tablegen -*-===//
//
//                     The LLVM Compiler Infrastructure
//
// This file is distributed under the University of Illinois Open Source
// License. See LICENSE.TXT for details.
//
//===----------------------------------------------------------------------===//

def HasMSA : Predicate<"Subtarget.hasMSA()">,
             AssemblerPredicate<"FeatureMSA">;

class MSAInst : MipsInst<(outs), (ins), "", [], NoItinerary, FrmOther> {
  let Predicates = [HasMSA];
  let Inst{31-26} = 0b011110;
}

class PseudoMSA<dag outs, dag ins, list<dag> pattern,
                InstrItinClass itin = IIPseudo>:
  MipsPseudo<outs, ins, pattern, itin> {
  let Predicates = [HasMSA];
}

class MSA_BIT_B_FMT<bits<3> major, bits<6> minor>: MSAInst {
  bits<5> ws;
  bits<5> wd;
  bits<3> m;

  let Inst{25-23} = major;
  let Inst{22-19} = 0b1110;
  let Inst{18-16} = m;
  let Inst{15-11} = ws;
  let Inst{10-6} = wd;
  let Inst{5-0} = minor;
}

class MSA_BIT_H_FMT<bits<3> major, bits<6> minor>: MSAInst {
  bits<5> ws;
  bits<5> wd;
  bits<4> m;

  let Inst{25-23} = major;
  let Inst{22-20} = 0b110;
  let Inst{19-16} = m;
  let Inst{15-11} = ws;
  let Inst{10-6} = wd;
  let Inst{5-0} = minor;
}

class MSA_BIT_W_FMT<bits<3> major, bits<6> minor>: MSAInst {
  bits<5> ws;
  bits<5> wd;
  bits<5> m;

  let Inst{25-23} = major;
  let Inst{22-21} = 0b10;
  let Inst{20-16} = m;
  let Inst{15-11} = ws;
  let Inst{10-6} = wd;
  let Inst{5-0} = minor;
}

class MSA_BIT_D_FMT<bits<3> major, bits<6> minor>: MSAInst {
  bits<5> ws;
  bits<5> wd;
  bits<6> m;

  let Inst{25-23} = major;
  let Inst{22} = 0b0;
  let Inst{21-16} = m;
  let Inst{15-11} = ws;
  let Inst{10-6} = wd;
  let Inst{5-0} = minor;
}

class MSA_2R_FILL_FMT<bits<8> major, bits<2> df, bits<6> minor>: MSAInst {
  bits<5> rs;
  bits<5> wd;

  let Inst{25-18} = major;
  let Inst{17-16} = df;
  let Inst{15-11} = rs;
  let Inst{10-6} = wd;
  let Inst{5-0} = minor;
}

class MSA_2R_FMT<bits<8> major, bits<2> df, bits<6> minor>: MSAInst {
  bits<5> ws;
  bits<5> wd;

  let Inst{25-18} = major;
  let Inst{17-16} = df;
  let Inst{15-11} = ws;
  let Inst{10-6} = wd;
  let Inst{5-0} = minor;
}

class MSA_2RF_FMT<bits<9> major, bits<1> df, bits<6> minor>: MSAInst {
  bits<5> ws;
  bits<5> wd;

  let Inst{25-17} = major;
  let Inst{16} = df;
  let Inst{15-11} = ws;
  let Inst{10-6} = wd;
  let Inst{5-0} = minor;
}

class MSA_3R_FMT<bits<3> major, bits<2> df, bits<6> minor>: MSAInst {
  bits<5> wt;
  bits<5> ws;
  bits<5> wd;

  let Inst{25-23} = major;
  let Inst{22-21} = df;
  let Inst{20-16} = wt;
  let Inst{15-11} = ws;
  let Inst{10-6} = wd;
  let Inst{5-0} = minor;
}

class MSA_3RF_FMT<bits<4> major, bits<1> df, bits<6> minor>: MSAInst {
  bits<5> wt;
  bits<5> ws;
  bits<5> wd;

  let Inst{25-22} = major;
  let Inst{21} = df;
  let Inst{20-16} = wt;
  let Inst{15-11} = ws;
  let Inst{10-6} = wd;
  let Inst{5-0} = minor;
}

class MSA_ELM_FMT<bits<10> major, bits<6> minor>: MSAInst {
  let Inst{25-16} = major;
  let Inst{5-0} = minor;
}

class MSA_ELM_B_FMT<bits<4> major, bits<6> minor>: MSAInst {
  bits<4> n;
  bits<5> ws;
  bits<5> wd;

  let Inst{25-22} = major;
  let Inst{21-20} = 0b00;
  let Inst{19-16} = n{3-0};
  let Inst{15-11} = ws;
  let Inst{10-6} = wd;
  let Inst{5-0} = minor;
}

class MSA_ELM_H_FMT<bits<4> major, bits<6> minor>: MSAInst {
  bits<4> n;
  bits<5> ws;
  bits<5> wd;

  let Inst{25-22} = major;
  let Inst{21-19} = 0b100;
  let Inst{18-16} = n{2-0};
  let Inst{15-11} = ws;
  let Inst{10-6} = wd;
  let Inst{5-0} = minor;
}

class MSA_ELM_W_FMT<bits<4> major, bits<6> minor>: MSAInst {
  bits<4> n;
  bits<5> ws;
  bits<5> wd;

  let Inst{25-22} = major;
  let Inst{21-18} = 0b1100;
  let Inst{17-16} = n{1-0};
  let Inst{15-11} = ws;
  let Inst{10-6} = wd;
  let Inst{5-0} = minor;
}

class MSA_ELM_D_FMT<bits<4> major, bits<6> minor>: MSAInst {
  bits<4> n;
  bits<5> ws;
  bits<5> wd;

  let Inst{25-22} = major;
  let Inst{21-17} = 0b11100;
  let Inst{16} = n{0};
  let Inst{15-11} = ws;
  let Inst{10-6} = wd;
  let Inst{5-0} = minor;
}

class MSA_ELM_COPY_B_FMT<bits<4> major, bits<6> minor>: MSAInst {
  bits<4> n;
  bits<5> ws;
  bits<5> rd;

  let Inst{25-22} = major;
  let Inst{21-20} = 0b00;
  let Inst{19-16} = n{3-0};
  let Inst{15-11} = ws;
  let Inst{10-6} = rd;
  let Inst{5-0} = minor;
}

class MSA_ELM_COPY_H_FMT<bits<4> major, bits<6> minor>: MSAInst {
  bits<4> n;
  bits<5> ws;
  bits<5> rd;

  let Inst{25-22} = major;
  let Inst{21-19} = 0b100;
  let Inst{18-16} = n{2-0};
  let Inst{15-11} = ws;
  let Inst{10-6} = rd;
  let Inst{5-0} = minor;
}

class MSA_ELM_COPY_W_FMT<bits<4> major, bits<6> minor>: MSAInst {
  bits<4> n;
  bits<5> ws;
  bits<5> rd;

  let Inst{25-22} = major;
  let Inst{21-18} = 0b1100;
  let Inst{17-16} = n{1-0};
  let Inst{15-11} = ws;
  let Inst{10-6} = rd;
  let Inst{5-0} = minor;
}

class MSA_ELM_INSERT_B_FMT<bits<4> major, bits<6> minor>: MSAInst {
  bits<6> n;
  bits<5> rs;
  bits<5> wd;

  let Inst{25-22} = major;
  let Inst{21-20} = 0b00;
  let Inst{19-16} = n{3-0};
  let Inst{15-11} = rs;
  let Inst{10-6} = wd;
  let Inst{5-0} = minor;
}

class MSA_ELM_INSERT_H_FMT<bits<4> major, bits<6> minor>: MSAInst {
  bits<6> n;
  bits<5> rs;
  bits<5> wd;

  let Inst{25-22} = major;
  let Inst{21-19} = 0b100;
  let Inst{18-16} = n{2-0};
  let Inst{15-11} = rs;
  let Inst{10-6} = wd;
  let Inst{5-0} = minor;
}

class MSA_ELM_INSERT_W_FMT<bits<4> major, bits<6> minor>: MSAInst {
  bits<6> n;
  bits<5> rs;
  bits<5> wd;

  let Inst{25-22} = major;
  let Inst{21-18} = 0b1100;
  let Inst{17-16} = n{1-0};
  let Inst{15-11} = rs;
  let Inst{10-6} = wd;
  let Inst{5-0} = minor;
}

class MSA_I5_FMT<bits<3> major, bits<2> df, bits<6> minor>: MSAInst {
  bits<5> imm;
  bits<5> ws;
  bits<5> wd;

  let Inst{25-23} = major;
  let Inst{22-21} = df;
  let Inst{20-16} = imm;
  let Inst{15-11} = ws;
  let Inst{10-6} = wd;
  let Inst{5-0} = minor;
}

class MSA_I8_FMT<bits<2> major, bits<6> minor>: MSAInst {
  bits<8> u8;
  bits<5> ws;
  bits<5> wd;

  let Inst{25-24} = major;
  let Inst{23-16} = u8;
  let Inst{15-11} = ws;
  let Inst{10-6} = wd;
  let Inst{5-0} = minor;
}

class MSA_I10_FMT<bits<3> major, bits<2> df, bits<6> minor>: MSAInst {
  let Inst{25-23} = major;
  let Inst{22-21} = df;
  let Inst{5-0} = minor;
}

class MSA_VEC_FMT<bits<5> major, bits<6> minor>: MSAInst {
  bits<5> wt;
  bits<5> ws;
  bits<5> wd;

  let Inst{25-21} = major;
  let Inst{20-16} = wt;
  let Inst{15-11} = ws;
  let Inst{10-6} = wd;
  let Inst{5-0} = minor;
}

class MSA_VECS10_FMT<bits<5> major, bits<6> minor>: MSAInst {
  let Inst{25-21} = major;
  let Inst{5-0} = minor;
}
