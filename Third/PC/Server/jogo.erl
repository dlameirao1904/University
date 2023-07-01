-module(jogo).
-export([acao/3,geraJogador/1, gerarBolas/2, inicio/2, jogo/1,string2Atom/1]).


% Estado = { J1, J2, Bolas}
%		   { {Pid1, Px1, Py1 , Tam1, Dir1}, {Pid2,Px2, Py2, Tam2, Dir2}, ListaBolas} 

inicio(Pid1, Pid2) ->
	{{Px1, Py1}, Tam1, Points1, Dir1, VelAng1, AceLin1} = {{10,350},20,0,0,4.33,0.83},
	{{Px2, Py2}, Tam2, Points2, Dir2, VelAng2, AceLin2} = {{690,350},20,0,0,4.33,0.83},

	ListaBolas = gerarBolas(10,[]),
	{ {Pid1, {Px1, Py1}, Tam1 ,Points1, Dir1, VelAng1, AceLin1}, {Pid2,{Px2, Py2}, Tam2,Points2, Dir2, VelAng2, AceLin2}, ListaBolas }.

	

	acao(From, Movimento, Estado) -> %devolve estado
	{ {Pid1, {Px1, Py1}, Tam1,Points1, Dir1, VelAng1, AceLin1}, {Pid2,{Px2, Py2}, Tam2, Points2, Dir2, VelAng2, AceLin2}, ListaBolas } = Estado,

	case From of
		Pid1 -> 
			{{AuxPx1, AuxPy1},NovaDir1, NovaVelAng1, NovaAceLin1} = moveJogador({Px1, Py1}, Movimento,Tam1,Dir1,VelAng1,AceLin1), %movimentar jogador		
			
			{{{AuxPx1,AuxPy1},Tam, Points1_1, NovaDir1, NovaVelAng1_1, NovaAceLin1_1}, NovaLista} = 
			capturaBolas({{AuxPx1, AuxPy1}, Tam1, Points1, NovaDir1, NovaVelAng1, NovaAceLin1}, ListaBolas), %aplicar a todas as bolas
			
			{{{ReturnPx1, ReturnPy1},ReturnTam1,Points1_2,ReturnDir1,ReturnVelAng1,ReturnAceLin1} , {{ReturnPx2, ReturnPy2},ReturnTam2,Points2_2, ReturnDir2,ReturnVelAng2,ReturnAceLin2}} 
			= jogCapturaJog({{AuxPx1,AuxPy1},Tam, Points1_1,NovaDir1,NovaVelAng1_1,NovaAceLin1_1} , {{Px2, Py2},Tam2, Points2, Dir2,VelAng2,AceLin2}); %verificar se come o outro jogador
			
		Pid2 -> 
			{{AuxPx2, AuxPy2},NovaDir2, NovaVelAng2, NovaAceLin2} = moveJogador({Px2, Py2}, Movimento,Tam2,Dir2,VelAng2,AceLin2), 

			{{{AuxPx2,AuxPy2},Tam, Points2_1, NovaDir2, NovaVelAng2_1, NovaAceLin2_1}, NovaLista} = 
			capturaBolas({{AuxPx2, AuxPy2}, Tam2, Points2, NovaDir2, NovaVelAng2, NovaAceLin2}, ListaBolas), %aplicar a todas as bolas

			{{{ReturnPx2, ReturnPy2},ReturnTam2, Points2_2,ReturnDir2,ReturnVelAng2,ReturnAceLin2},{{ReturnPx1,ReturnPy1},ReturnTam1, Points1_2,ReturnDir1,ReturnVelAng1,ReturnAceLin1}} = 
			jogCapturaJog({{AuxPx2, AuxPy2},Tam, Points2_1, NovaDir2,NovaVelAng2_1,NovaAceLin2_1},{{Px1,Py1},Tam1, Points1, Dir1,VelAng1,AceLin1} ) %nao interessa a ordem
	
	end,
	

	case Points1_2 > Points2_2 of
		true -> 
			NovosPoints1 = 1,
			NovosPoints2 = 0;
		false -> 
			case Points1_2 == Points2_2 of
				true -> 
					NovosPoints1 = Points1_2,
					NovosPoints2 = Points2_2;
				false -> 
					NovosPoints1 = 0,
					NovosPoints2 = 1	
			end
				
	end,
	
	{ {Pid1, {ReturnPx1, ReturnPy1},ReturnTam1,NovosPoints1, ReturnDir1, ReturnVelAng1, ReturnAceLin1}, {Pid2, {ReturnPx2, ReturnPy2}, ReturnTam2, NovosPoints2, ReturnDir2, ReturnVelAng2, ReturnAceLin2}, NovaLista}.


moveJogador({Px1,Py1},Movimento,Tam,Dir,VelAng,AceLin) -> %retorna a nova posição do jogador
	
	% Calcula a nova posição do jogador de acordo com a tecla pressionada
	case Movimento of 
		direita ->
    		{{Px1, Py1},Dir+VelAng,VelAng,AceLin};
    	esquerda ->
    		{{Px1, Py1},Dir-VelAng,VelAng,AceLin};
		esqfrente ->
    	    Radianos = (Dir * math:pi()) / 180, 
			{{ somaCoord(Px1, ((40 / Tam) * math:sin(Radianos)* AceLin)),  somaCoord(Py1, - ((40 / Tam) * math:cos(Radianos)* AceLin))}, Dir-VelAng,VelAng,AceLin};
		dirfrente -> 
			Radianos = (Dir * math:pi()) / 180, 
			{{ somaCoord(Px1, ((40 / Tam) * math:sin(Radianos)* AceLin)),  somaCoord(Py1, - ((40 / Tam) * math:cos(Radianos)* AceLin))}, (Dir+VelAng),VelAng,AceLin};
		frente ->
			Radianos = (Dir * math:pi()) / 180, 
			{{ somaCoord(Px1, (((40 / Tam)*math:sin(Radianos)* AceLin ))),  somaCoord(Py1, - (((40 / Tam) *math:cos(Radianos)*AceLin)))}, Dir,VelAng,AceLin};
		_ -> {{Px1, Py1},Dir,VelAng,AceLin}
end.
			

capturaBolas(J1, []) ->
    {J1, []};

capturaBolas(J1, [Head | Bolas]) ->
    {{Px1, Py1}, Tam1, Points, Dir1, VelAng1, AceLin1} = J1,
    {{_, _},  _, Tipo} = Head,
    
    X = jogCapturaBola(J1, Head),
    
    case X of
        true ->
            case Tipo of
                1 -> % Bola verde (aumenta velocidade)
                    if VelAng1 < 21.65  -> %so pode apanhar 5 bolas verdes logo aumentar no maximo 5 * 2.13 = 10.65rad/s
                        J1a = {{Px1, Py1}, Tam1, Points, Dir1, VelAng1 + 4.33, AceLin1},
                        B = geraRandBola(Tam1),
                        NovoBolas = [B];
                    true ->
                        J1a = J1,
                        NovoBolas = [Head]
                    end;
                2 -> % Bola azul (aumenta aceleração)
                    if AceLin1 < 1.65 -> %so pode apanhar 5 bolas azuis logo aumentar no maximo 5 * 0.33 = 1.65 m/s2
                        J1a = {{Px1, Py1}, Tam1, Points, Dir1, VelAng1, AceLin1 + 0.33},
                        B = geraRandBola(Tam1),
                        NovoBolas = [B];
                    true ->
                        J1a = J1,
                        NovoBolas = [Head]
                    end;
                3 -> % Bola vermelha (retira bônus)
                    J1a = {{Px1, Py1}, Tam1, Points, Dir1, 4.33, 0.83},
                    B = geraRandBola(Tam1),
                    NovoBolas = [B]
            end;
        false ->
            J1a = J1,
            NovoBolas = [Head]
    end,

    {J1b, NovaLista} = capturaBolas(J1a, Bolas),
    {J1b, NovoBolas ++ NovaLista}.


jogCapturaBola({{Px1,Py1},Tam1, _,_,_,_} , {{Px2, Py2},Tam2,_}) -> %recebe ({Px1,Py1,Tam1,Dir1, VelAng1, Acelin1} , {Px2, Py2,Tam2, Tipo})
	
	Dist = calculaDist( {Px1,Py1} , {Px2,Py2} ),
	Tam1_2 = Tam1/2,
	Tam2_2 = Tam2/2,
    case Tam1_2 >= Dist+Tam2_2 of %o Jog captura a BOLA
		true -> true;
		false -> false
	end.

radians(X) ->
	math:pi() * X  / 180.

jogCapturaJog({{Px1, Py1}, Tam1, Points1, Dir1, VelAng1, AceLin1}, {{Px2, Py2}, Tam2, Points2, Dir2, VelAng2, AceLin2}) ->
	Dist = calculaDist({Px1, Py1}, {Px2, Py2}),
	Angulo1 = radians(abs(Dir1 - Dir2)),
	io:format("angulo: ~p~n", [Angulo1]),
	case ((Angulo1 < math:pi() / 2) orelse (Angulo1 > (3*math:pi())/2)) andalso (Tam1 >= Dist + Tam2 / 2) of
		true -> % Jog1 colide com Jog2 por trás
			% Jogador 1 ganha um ponto 
			% Jogador 2 reaparece em uma posição aleatória
			{{{Px1,Py1},Tam1,Points1+1,Dir1, 4.33 , 0.83} , geraJogador(Points2)};
		false -> % Jog1 não colide com Jog2 por trás
			{{{Px1, Py1}, Tam1, Points1, Dir1, VelAng1, AceLin1}, {{Px2, Py2}, Tam2,Points2, Dir2, VelAng2, AceLin2}}
	end.
	

calculaDist({Px1,Py1} , {Px2,Py2} ) -> % retorn um float
    X = math:sqrt( math:pow((Px2-Px1),2) + math:pow((Py2-Py1),2) ),
	X.


somaCoord(P,A) -> %recebe a componente da coordenada e qual o aumento, e devolve a componente da coordenada
  case P+A >= 700 of
	  true -> 0;
	  false -> 
		  case P+A =< 0 of 
				  true -> 700;
				  false -> P+A
			   end
	end.

geraRandBola(Tam) -> %recebe o Tam mais pequeno, retorn {Px,Py,Tam}
	Bola = {{rand:uniform(700), rand:uniform(700)}, Tam/3, rand:uniform(3)},
	Bola.


geraJogador(Points) -> %devolve {Px,Py, Tam, TamMac, Dir, VelAng, AceLin}
	{{rand:uniform(700), rand:uniform(700)}, 20, Points, 180, 2.13, 0.23}.

gerarBolas(0,Lista) -> Lista;
gerarBolas(N,Lista) -> 
	Bola = geraRandBola(20),
	NovaLista = Lista ++ [Bola],
	gerarBolas(N-1,NovaLista).

jogo(Estado)->
	io:format("Estado: ~p~n", [Estado]),
	% {pid,{Px,Py}, Tam, TamMac, Dir, VelAng, AceLin}
    {{Pid1,_,_,Points1,_,_,_},{Pid2,_,_,Points2,_,_,_},_} = Estado,
    Pid1 ! {line,estado2String(Estado)++"\n"},
    Pid2 ! {line,estado2String(Estado)++"\n"},
    receive
        {line,From, Data} ->
            [H|_] = string:split(Data," "),
            case string2Atom(H) of
                esquerda -> NewEstado = acao(From,esquerda,Estado), jogo(NewEstado);
                direita -> NewEstado = acao(From,direita,Estado), jogo(NewEstado);
                frente -> NewEstado = acao(From,frente,Estado), jogo(NewEstado);
                tras -> NewEstado = acao(From,tras,Estado), jogo(NewEstado);
				esqfrente -> NewEstado = acao(From,esqfrente,Estado), jogo(NewEstado);
				esqtras -> NewEstado = acao(From,esqtras,Estado), jogo(NewEstado);
				dirtras -> NewEstado = acao(From,dirtras,Estado), jogo(NewEstado);
				dirfrente -> NewEstado = acao(From,dirfrente,Estado), jogo(NewEstado);
				null -> jogo(Estado)
            end;
        terminar ->
			Pid1 ! {line,"endGame\n"},
			Pid1 ! {prepara, servidor},
			Pid2 ! {line,"endGame\n"},
            Pid2 ! {prepara, servidor},
            case Points1>Points2 of
                true -> servidor ! {endedGame,self(),Pid1,Points1,Pid2,Points2};
                false ->
					case Points1<Points2 of
						true ->  servidor ! {endedGame,self(),Pid2,Points2,Pid1,Points1};
						false ->  servidor ! {endedGame,self(),Pid2,Points2,Pid1,Points1}
					end
            end
    end.

estado2String(Estado)->
    {P1,P2,Bolas} = Estado,
    {Pid,{X,Y},Massa,Points1,Direcao, VelAng, AceLin} = P1,
    {Pid2,{X2,Y2},Massa2,Points2,Direcao2, VelAng2, AceLin2} = P2,
    lists:flatten(io_lib:format("~p ~p ~p ~p ~p ~p ~p ~p ~p ~p ~p ~p ~p ~p ~p ~p ",[Pid,X,Y,Massa,Points1,Direcao,VelAng,AceLin,Pid2,X2,Y2,Massa2,Points2,Direcao2,VelAng2,AceLin2]))++bolas2String(Bolas).

bolas2String([]) -> "";
bolas2String([H|T]) ->
    {{X,Y},Massa,Tipo} = H,
    lists:flatten(io_lib:format("~p ~p ~p ~p ",[X,Y,Massa,Tipo]))++bolas2String(T).

string2Atom(String) ->
    case string:equal(String,"create") of
        true -> create;
        false ->
            case string:equal(String,"login") of
                true -> login;
                false ->
                    case string:equal(String,"close") of
                        true -> close;
                        false ->
                            case string:equal(String,"play") of
                                true -> play;
                                false ->
                                    case string:equal(String,"logout") of
                                        true -> logout;
                                        false ->
											case string:equal(String,"getScore") of
												true -> getScore;
												false ->
													case string:equal(String,"esquerda") of
														true -> esquerda;
														false ->
															case string:equal(String,"direita") of
																true -> direita;
																false ->
																	case string:equal(String,"frente") of
																		true -> frente;
																		false ->
																			case string:equal(String,"tras") of
																				true -> tras;
																				false ->
																					case string:equal(String,"esqfrente") of
																						true -> esqfrente;
																						false ->
																							case string:equal(String,"esqtras") of
																								true -> esqtras;
																								false ->
																									case string:equal(String,"dirtras") of
																										true -> dirtras;
																										false -> 
																											case string:equal(String,"dirfrente") of
																												true -> dirfrente;
																												false -> null
																											end
																									end
																							end
																					end
																			end
																	end
															end
													end
											end
                                    end
                            end
                    end
            end
    end.
