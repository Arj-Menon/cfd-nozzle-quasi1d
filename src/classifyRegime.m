function regime = classifyRegime(pe_p0, crit)
% CLASSIFYREGIME Decide which of the 3 code paths applies. 
% pe_p0 - Back pressure ratio P_e/P0
% crit - struct from criticalPressures
% Returns 'unchoked' , 'shock', or 'supersonic'.

% Guard for pe/p0 to remain is (0,1]
    if pe_p0 <=0 || pe_p0 > 1
        error ('classifyRegime: p_e/p0 = %.4f is outside (0,1].', pe_p0);
    end

    if pe_p0 >= crit.p1
    regime = 'unchoked'; % At or above the 1st critical the throat never reaches sonic
                         % A* comes out FICTITIOUS abd smaller than A_t.
    elseif pe_p0 > crit.p2
    regime = 'shock'; % bet 1st and 2nd critical; choked with normal shock standing somewhere
                      % in the divergin section.
    else 
    regime = 'supersonic'; % At or below the 2nd critical the shock has left the nozzle.
                           % Overexpanded, design, underexpanded - the
                           % interrior is identitical in all three, so one
                           % path covers them. 
    end 
end 
