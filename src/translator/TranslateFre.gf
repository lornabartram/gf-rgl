--# -path=.:../chunk:alltenses

concrete TranslateFre of Translate = 
  TenseFre,
  NounFre - [PPartNP],
  AdjectiveFre,
  NumeralFre,
  SymbolFre [
    PN, Symb, String, CN, Card, NP, MkSymb, SymbPN, CNNumNP
    ],
  ConjunctionFre,
  VerbFre -  [
    UseCopula,  
    SlashV2V, PassV2, ComplVV  -- generalized in Extensions
    ],
  AdverbFre,
  PhraseFre,
  SentenceFre,
  QuestionFre - [
    QuestCl,QuestIAdv -- french-specific overrides
    ],
  RelativeFre,
  IdiomFre [
    NP, VP, Tense, Cl, ProgrVP, ExistNP, SelfAdvVP, SelfAdVVP, SelfNP, 
    neutr, sjalv
    ],
  ConstructionFre,
  DocumentationFre,

  ChunkFre,
  ExtensionsFre [CompoundCN,AdAdV,UttAdV,ApposNP,MkVPI, MkVPS, PredVPS, PassVPSlash, PassAgentVPSlash],

  DictionaryFre ** 
open PhonoFre, MorphoFre, ResFre, CommonRomance, ParadigmsFre, SyntaxFre, Prelude, (G = GrammarFre) in {

flags
  literal=Symb ;
  coding = utf8 ;

-- overrides from Lang

lin
  QuestCl cl = 
    {s = \\t,a,p =>                             -- est-ce qu'il dort ?
            let cls = cl.s ! DDir ! t ! a ! p 
            in table {
              QDir   => "est-ce" ++ elisQue ++ cls ! Indic ;
              QIndir => subjIf ++ cls ! Indic
              }
      }
  | {s = \\t,a,p =>                             -- dort-il ?
            let cls = cl.s ! DInv ! t ! a ! p 
            in table {
              QDir   => cls ! Indic ;
              QIndir => subjIf ++ cls ! Indic
              }
      }
  | G.QuestCl cl                                -- il dort ?
  ;


  QuestIAdv iadv cl = 
     G.QuestIAdv iadv cl                       -- où dort-il
   | {s = \\t,a,p,q =>                         -- où est-ce qu'il dort        
            let 
              ord = DDir ;
              cls = cl.s ! ord ! t ! a ! p ! Indic ;
              why = iadv.s
            in why ++ "est-ce" ++ elisQue ++ cls
      } ;


}
