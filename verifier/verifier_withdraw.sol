// SPDX-License-Identifier: GPL-3.0
/*
    Copyright 2021 0KIMS association.

    This file is generated with [snarkJS](https://github.com/iden3/snarkjs).

    snarkJS is a free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    snarkJS is distributed in the hope that it will be useful, but WITHOUT
    ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
    or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public
    License for more details.

    You should have received a copy of the GNU General Public License
    along with snarkJS. If not, see <https://www.gnu.org/licenses/>.
*/

pragma solidity >=0.7.0 <0.9.0;

contract Groth16Verifier {
    // Scalar field size
    uint256 constant r    = 21888242871839275222246405745257275088548364400416034343698204186575808495617;
    // Base field size
    uint256 constant q   = 21888242871839275222246405745257275088696311157297823662689037894645226208583;

    // Verification Key data
    uint256 constant alphax  = 20491192805390485299153009773594534940189261866228447918068658471970481763042;
    uint256 constant alphay  = 9383485363053290200918347156157836566562967994039712273449902621266178545958;
    uint256 constant betax1  = 4252822878758300859123897981450591353533073413197771768651442665752259397132;
    uint256 constant betax2  = 6375614351688725206403948262868962793625744043794305715222011528459656738731;
    uint256 constant betay1  = 21847035105528745403288232691147584728191162732299865338377159692350059136679;
    uint256 constant betay2  = 10505242626370262277552901082094356697409835680220590971873171140371331206856;
    uint256 constant gammax1 = 11559732032986387107991004021392285783925812861821192530917403151452391805634;
    uint256 constant gammax2 = 10857046999023057135944570762232829481370756359578518086990519993285655852781;
    uint256 constant gammay1 = 4082367875863433681332203403145435568316851327593401208105741076214120093531;
    uint256 constant gammay2 = 8495653923123431417604973247489272438418190587263600148770280649306958101930;
    uint256 constant deltax1 = 17292684838988919145391961159453843250667798336908215914693563987318382611256;
    uint256 constant deltax2 = 6705080340246026347426100787065884600430580376992667304980937169917114061276;
    uint256 constant deltay1 = 16809654409353890254901954278487775658338303807412081126820309114626807716079;
    uint256 constant deltay2 = 2466746199851025916100679048516371379944448275160181172350905385263691352433;

    
    uint256 constant IC0x = 16385680106585243790068560961914093608035733029392667602318256217897534734086;
    uint256 constant IC0y = 17511142062805273227863594658168611809327750721627769741977781576930013174968;
    
    uint256 constant IC1x = 11123728643388648020545911269126062775093972590040301402970169014594304643563;
    uint256 constant IC1y = 20470401754096955205840228667612988823441547477385318029239215712323953491841;
    
    uint256 constant IC2x = 6035566849394318126193103299889217807061851441060812845196781650493242148678;
    uint256 constant IC2y = 13611282753572668008116854835272002334882661964105965298509831705433360455797;
    
    uint256 constant IC3x = 16446352812191096083044851846025202884161789413660904876878868787431632936035;
    uint256 constant IC3y = 932737417022382675679210473370837778042434842752011782404458373566872973156;
    
    uint256 constant IC4x = 6847684673528422258131669048817548469560669741198664019279936103230995816718;
    uint256 constant IC4y = 14148233140251539399549418809766177601606695128013152160242212137030771827942;
    
    uint256 constant IC5x = 2163583907338311931987182025808833297468052014336467002888499298329081584038;
    uint256 constant IC5y = 4912328159581682275909460581072064023735361054140513433972213281611318759011;
    
    uint256 constant IC6x = 3055559968265374757670714563957255088492222850677362718843082557667759692041;
    uint256 constant IC6y = 17693659793202220663944661766930391399692297900176514947180187810666121264557;
    
    uint256 constant IC7x = 7738803581661567420474406711081294301134888594689314987096558601251768711811;
    uint256 constant IC7y = 17273188542904956660133078128640641245025373233604619229159707346188448238860;
    
    uint256 constant IC8x = 13495629046770222433536488232250745208494187728882783195588922929335769573019;
    uint256 constant IC8y = 17064352988825429455377817915370564865307574742235229023521943400184067849067;
    
    uint256 constant IC9x = 14508972908669851910341267297878757706212471236935443824369316884858217844297;
    uint256 constant IC9y = 17272072368860793475705374349107612217802509050276816735368044501174652925195;
    
    uint256 constant IC10x = 12365892369586233937562329607962759936605147806355921390124688604563377024875;
    uint256 constant IC10y = 3567596839474830421162127736395440271239224187705904520266397985103812734428;
    
    uint256 constant IC11x = 11467872899241732926831510005503835660041964255300729064691988700437719750535;
    uint256 constant IC11y = 1377151868056857045921516591745126556631632644090286619330963701166534785649;
    
    uint256 constant IC12x = 1939838970303889207859479868925709101478050583341754990618522939904343366513;
    uint256 constant IC12y = 4851045835644764890328845453950364168837524893939704846019256478018499136854;
    
    uint256 constant IC13x = 12987222580755017561639105920842080103603364413798264290871453606190919637355;
    uint256 constant IC13y = 118004984119517047394229763013357138051463372793138560547548701167549202231;
    
    uint256 constant IC14x = 8401107829323291626200946397292641837624036869037851332079115151613779689175;
    uint256 constant IC14y = 15495536714132031557806471572405078815352514604443192148285989291817649010302;
    
    uint256 constant IC15x = 18633813798605623327019785649416242394936893521218495044355558274514558531217;
    uint256 constant IC15y = 708169338961349438599808620444561565238977133925447802279425026912751855657;
    
    uint256 constant IC16x = 17093600483507741763043206400986404445073137085725534677082590592285357119969;
    uint256 constant IC16y = 14463569527451815964785638695851642537772483281157583973293406897825343070106;
    
    uint256 constant IC17x = 2662586785245565259869375096178882206690763801281097235093156301561815098781;
    uint256 constant IC17y = 5097003922073858188186175853497749321358985238086103917239015100531666270580;
    
    uint256 constant IC18x = 5463283236019230227702876611525259328989493778479771016377073973786642706969;
    uint256 constant IC18y = 21158786664665629433731005391190731548910913877848823427417172791761872817979;
    
    uint256 constant IC19x = 17693260707058865548832563867119313009542178952624456815744586696526406231687;
    uint256 constant IC19y = 16913521891250195956113677177074263687518772158045457993567709708468060639092;
    
    uint256 constant IC20x = 20645435901498291737798169679068793341127072636366170913682919898226275516935;
    uint256 constant IC20y = 17760192878643990119432816288563681489176421510243705371743315400057992156099;
    
    uint256 constant IC21x = 2192940757449557959860955618370577559727390388662759841055958293067362413339;
    uint256 constant IC21y = 7749503620685111575195633915164672631863287307385197775780917790568912712176;
    
    uint256 constant IC22x = 18016912849796559737201628266572179650341400087976446817270983306523308013138;
    uint256 constant IC22y = 8711070200260472572495253512397168035722159895744975975516218432819774631374;
    
    uint256 constant IC23x = 1616394528594600499654576931642513196362674696245423595920054444948772471263;
    uint256 constant IC23y = 9196516568075852893171738686179471225111329405369204541262114359685478390929;
    
    uint256 constant IC24x = 5525904997799465666604517854627377704539986993839217562822198685693264253048;
    uint256 constant IC24y = 12552130037668612955262616618188537022443387996520760167139816132338873475016;
    
    uint256 constant IC25x = 14745579501773414715580084309927141566229763679697410189365606942149234482251;
    uint256 constant IC25y = 10179011185468799682843215417300467366635645734271641696389140981881331697783;
    
    uint256 constant IC26x = 11278929141809023544151292186833311687904450661085631068885599318410707260330;
    uint256 constant IC26y = 4578301961304296011590332272460063872707559481928127175789550973791529683220;
    
    uint256 constant IC27x = 7573240611551027536596778407752462287204658838604960967809587171957181444633;
    uint256 constant IC27y = 15834141924307866595977078116286415245969241845063293317524443127454181661030;
    
    uint256 constant IC28x = 9890265086536147276338534736083974033090484769931309438317811896188477459789;
    uint256 constant IC28y = 18018568072750644686409530489173540036276845139948206985878160261703300368260;
    
    uint256 constant IC29x = 15326934940501221965038842250632770811616359692137845614456527308808289141451;
    uint256 constant IC29y = 917404517910612098899659171352756668232429231612168049201409801187286641413;
    
    uint256 constant IC30x = 13208562596600982762346779797936343844749743817542573535981369678634980499597;
    uint256 constant IC30y = 9647963007379231413311541667696829469238228913318710635722012109477358852131;
    
    uint256 constant IC31x = 3479677047533984151619004850177081516435871129501562256159093949836686143132;
    uint256 constant IC31y = 3285160637015242646981254019664835193089798106265232750960821537409582634624;
    
    uint256 constant IC32x = 8094463824125660036076805300286082398604300752633617211074561161997866527533;
    uint256 constant IC32y = 19802000358825393119897907470307802677098110918889706938712432092548915501409;
    
    uint256 constant IC33x = 6809480966108245670903447256406522858088365085843104084555880812069452932232;
    uint256 constant IC33y = 8268803416624125902559661107193349659631091002615895200454850595078886873687;
    
    uint256 constant IC34x = 2545240721048615196330248418639745229853262572090830468888473867576322621081;
    uint256 constant IC34y = 11931921097200476993224920834984272929587330825241427611883046043420107862201;
    
    uint256 constant IC35x = 12716890040231747860523243935418092427046289678221173399334466040872980446810;
    uint256 constant IC35y = 14766967885055371889333408798349050203817404504731680518413779269934084107790;
    
    uint256 constant IC36x = 2643417533492891505370738501408324567218281362347159961567672248169982436716;
    uint256 constant IC36y = 4813778316175942097377695677087825091626775055301281933054459430223251303305;
    
    uint256 constant IC37x = 15475228712960345481756466607671558572693967166238829823748839562397179502216;
    uint256 constant IC37y = 6149481571895378926600015114283128202628944998260596623916633239216919029139;
    
    uint256 constant IC38x = 7815803879609622917632446421326725223905899822374022978959706420043868292292;
    uint256 constant IC38y = 3267046753272444319165231136116727066967481387619743947185790944041738479968;
    
    uint256 constant IC39x = 20006524295215972004446018954753859111306231654360218613711553802195871805896;
    uint256 constant IC39y = 21410091365698071733299058618696060396529390261483436016797177861867877727689;
    
    uint256 constant IC40x = 3066963499963178717731265771679611348952155646020030623116751461749874574315;
    uint256 constant IC40y = 17536137759937903210660662443380188054062706219610972903951166170809733466984;
    
    uint256 constant IC41x = 14483382502520207519509740444838921259140943984678424774569349765382326676860;
    uint256 constant IC41y = 10752909828652895521830470644921204147537244505870964316535386964370600106309;
    
 
    // Memory data
    uint16 constant pVk = 0;
    uint16 constant pPairing = 128;

    uint16 constant pLastMem = 896;

    function verifyProof(uint[2] calldata _pA, uint[2][2] calldata _pB, uint[2] calldata _pC, uint[41] calldata _pubSignals) public view returns (bool) {
        assembly {
            function checkField(v) {
                if iszero(lt(v, r)) {
                    mstore(0, 0)
                    return(0, 0x20)
                }
            }
            
            // G1 function to multiply a G1 value(x,y) to value in an address
            function g1_mulAccC(pR, x, y, s) {
                let success
                let mIn := mload(0x40)
                mstore(mIn, x)
                mstore(add(mIn, 32), y)
                mstore(add(mIn, 64), s)

                success := staticcall(sub(gas(), 2000), 7, mIn, 96, mIn, 64)

                if iszero(success) {
                    mstore(0, 0)
                    return(0, 0x20)
                }

                mstore(add(mIn, 64), mload(pR))
                mstore(add(mIn, 96), mload(add(pR, 32)))

                success := staticcall(sub(gas(), 2000), 6, mIn, 128, pR, 64)

                if iszero(success) {
                    mstore(0, 0)
                    return(0, 0x20)
                }
            }

            function checkPairing(pA, pB, pC, pubSignals, pMem) -> isOk {
                let _pPairing := add(pMem, pPairing)
                let _pVk := add(pMem, pVk)

                mstore(_pVk, IC0x)
                mstore(add(_pVk, 32), IC0y)

                // Compute the linear combination vk_x
                
                g1_mulAccC(_pVk, IC1x, IC1y, calldataload(add(pubSignals, 0)))
                
                g1_mulAccC(_pVk, IC2x, IC2y, calldataload(add(pubSignals, 32)))
                
                g1_mulAccC(_pVk, IC3x, IC3y, calldataload(add(pubSignals, 64)))
                
                g1_mulAccC(_pVk, IC4x, IC4y, calldataload(add(pubSignals, 96)))
                
                g1_mulAccC(_pVk, IC5x, IC5y, calldataload(add(pubSignals, 128)))
                
                g1_mulAccC(_pVk, IC6x, IC6y, calldataload(add(pubSignals, 160)))
                
                g1_mulAccC(_pVk, IC7x, IC7y, calldataload(add(pubSignals, 192)))
                
                g1_mulAccC(_pVk, IC8x, IC8y, calldataload(add(pubSignals, 224)))
                
                g1_mulAccC(_pVk, IC9x, IC9y, calldataload(add(pubSignals, 256)))
                
                g1_mulAccC(_pVk, IC10x, IC10y, calldataload(add(pubSignals, 288)))
                
                g1_mulAccC(_pVk, IC11x, IC11y, calldataload(add(pubSignals, 320)))
                
                g1_mulAccC(_pVk, IC12x, IC12y, calldataload(add(pubSignals, 352)))
                
                g1_mulAccC(_pVk, IC13x, IC13y, calldataload(add(pubSignals, 384)))
                
                g1_mulAccC(_pVk, IC14x, IC14y, calldataload(add(pubSignals, 416)))
                
                g1_mulAccC(_pVk, IC15x, IC15y, calldataload(add(pubSignals, 448)))
                
                g1_mulAccC(_pVk, IC16x, IC16y, calldataload(add(pubSignals, 480)))
                
                g1_mulAccC(_pVk, IC17x, IC17y, calldataload(add(pubSignals, 512)))
                
                g1_mulAccC(_pVk, IC18x, IC18y, calldataload(add(pubSignals, 544)))
                
                g1_mulAccC(_pVk, IC19x, IC19y, calldataload(add(pubSignals, 576)))
                
                g1_mulAccC(_pVk, IC20x, IC20y, calldataload(add(pubSignals, 608)))
                
                g1_mulAccC(_pVk, IC21x, IC21y, calldataload(add(pubSignals, 640)))
                
                g1_mulAccC(_pVk, IC22x, IC22y, calldataload(add(pubSignals, 672)))
                
                g1_mulAccC(_pVk, IC23x, IC23y, calldataload(add(pubSignals, 704)))
                
                g1_mulAccC(_pVk, IC24x, IC24y, calldataload(add(pubSignals, 736)))
                
                g1_mulAccC(_pVk, IC25x, IC25y, calldataload(add(pubSignals, 768)))
                
                g1_mulAccC(_pVk, IC26x, IC26y, calldataload(add(pubSignals, 800)))
                
                g1_mulAccC(_pVk, IC27x, IC27y, calldataload(add(pubSignals, 832)))
                
                g1_mulAccC(_pVk, IC28x, IC28y, calldataload(add(pubSignals, 864)))
                
                g1_mulAccC(_pVk, IC29x, IC29y, calldataload(add(pubSignals, 896)))
                
                g1_mulAccC(_pVk, IC30x, IC30y, calldataload(add(pubSignals, 928)))
                
                g1_mulAccC(_pVk, IC31x, IC31y, calldataload(add(pubSignals, 960)))
                
                g1_mulAccC(_pVk, IC32x, IC32y, calldataload(add(pubSignals, 992)))
                
                g1_mulAccC(_pVk, IC33x, IC33y, calldataload(add(pubSignals, 1024)))
                
                g1_mulAccC(_pVk, IC34x, IC34y, calldataload(add(pubSignals, 1056)))
                
                g1_mulAccC(_pVk, IC35x, IC35y, calldataload(add(pubSignals, 1088)))
                
                g1_mulAccC(_pVk, IC36x, IC36y, calldataload(add(pubSignals, 1120)))
                
                g1_mulAccC(_pVk, IC37x, IC37y, calldataload(add(pubSignals, 1152)))
                
                g1_mulAccC(_pVk, IC38x, IC38y, calldataload(add(pubSignals, 1184)))
                
                g1_mulAccC(_pVk, IC39x, IC39y, calldataload(add(pubSignals, 1216)))
                
                g1_mulAccC(_pVk, IC40x, IC40y, calldataload(add(pubSignals, 1248)))
                
                g1_mulAccC(_pVk, IC41x, IC41y, calldataload(add(pubSignals, 1280)))
                

                // -A
                mstore(_pPairing, calldataload(pA))
                mstore(add(_pPairing, 32), mod(sub(q, calldataload(add(pA, 32))), q))

                // B
                mstore(add(_pPairing, 64), calldataload(pB))
                mstore(add(_pPairing, 96), calldataload(add(pB, 32)))
                mstore(add(_pPairing, 128), calldataload(add(pB, 64)))
                mstore(add(_pPairing, 160), calldataload(add(pB, 96)))

                // alpha1
                mstore(add(_pPairing, 192), alphax)
                mstore(add(_pPairing, 224), alphay)

                // beta2
                mstore(add(_pPairing, 256), betax1)
                mstore(add(_pPairing, 288), betax2)
                mstore(add(_pPairing, 320), betay1)
                mstore(add(_pPairing, 352), betay2)

                // vk_x
                mstore(add(_pPairing, 384), mload(add(pMem, pVk)))
                mstore(add(_pPairing, 416), mload(add(pMem, add(pVk, 32))))


                // gamma2
                mstore(add(_pPairing, 448), gammax1)
                mstore(add(_pPairing, 480), gammax2)
                mstore(add(_pPairing, 512), gammay1)
                mstore(add(_pPairing, 544), gammay2)

                // C
                mstore(add(_pPairing, 576), calldataload(pC))
                mstore(add(_pPairing, 608), calldataload(add(pC, 32)))

                // delta2
                mstore(add(_pPairing, 640), deltax1)
                mstore(add(_pPairing, 672), deltax2)
                mstore(add(_pPairing, 704), deltay1)
                mstore(add(_pPairing, 736), deltay2)


                let success := staticcall(sub(gas(), 2000), 8, _pPairing, 768, _pPairing, 0x20)

                isOk := and(success, mload(_pPairing))
            }

            let pMem := mload(0x40)
            mstore(0x40, add(pMem, pLastMem))

            // Validate that all evaluations ∈ F
            
            checkField(calldataload(add(_pubSignals, 0)))
            
            checkField(calldataload(add(_pubSignals, 32)))
            
            checkField(calldataload(add(_pubSignals, 64)))
            
            checkField(calldataload(add(_pubSignals, 96)))
            
            checkField(calldataload(add(_pubSignals, 128)))
            
            checkField(calldataload(add(_pubSignals, 160)))
            
            checkField(calldataload(add(_pubSignals, 192)))
            
            checkField(calldataload(add(_pubSignals, 224)))
            
            checkField(calldataload(add(_pubSignals, 256)))
            
            checkField(calldataload(add(_pubSignals, 288)))
            
            checkField(calldataload(add(_pubSignals, 320)))
            
            checkField(calldataload(add(_pubSignals, 352)))
            
            checkField(calldataload(add(_pubSignals, 384)))
            
            checkField(calldataload(add(_pubSignals, 416)))
            
            checkField(calldataload(add(_pubSignals, 448)))
            
            checkField(calldataload(add(_pubSignals, 480)))
            
            checkField(calldataload(add(_pubSignals, 512)))
            
            checkField(calldataload(add(_pubSignals, 544)))
            
            checkField(calldataload(add(_pubSignals, 576)))
            
            checkField(calldataload(add(_pubSignals, 608)))
            
            checkField(calldataload(add(_pubSignals, 640)))
            
            checkField(calldataload(add(_pubSignals, 672)))
            
            checkField(calldataload(add(_pubSignals, 704)))
            
            checkField(calldataload(add(_pubSignals, 736)))
            
            checkField(calldataload(add(_pubSignals, 768)))
            
            checkField(calldataload(add(_pubSignals, 800)))
            
            checkField(calldataload(add(_pubSignals, 832)))
            
            checkField(calldataload(add(_pubSignals, 864)))
            
            checkField(calldataload(add(_pubSignals, 896)))
            
            checkField(calldataload(add(_pubSignals, 928)))
            
            checkField(calldataload(add(_pubSignals, 960)))
            
            checkField(calldataload(add(_pubSignals, 992)))
            
            checkField(calldataload(add(_pubSignals, 1024)))
            
            checkField(calldataload(add(_pubSignals, 1056)))
            
            checkField(calldataload(add(_pubSignals, 1088)))
            
            checkField(calldataload(add(_pubSignals, 1120)))
            
            checkField(calldataload(add(_pubSignals, 1152)))
            
            checkField(calldataload(add(_pubSignals, 1184)))
            
            checkField(calldataload(add(_pubSignals, 1216)))
            
            checkField(calldataload(add(_pubSignals, 1248)))
            
            checkField(calldataload(add(_pubSignals, 1280)))
            
            checkField(calldataload(add(_pubSignals, 1312)))
            

            // Validate all evaluations
            let isValid := checkPairing(_pA, _pB, _pC, _pubSignals, pMem)

            mstore(0, isValid)
             return(0, 0x20)
         }
     }
 }
