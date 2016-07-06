% PlaySound.m
set(handles.IsPlayPanel, 'Background', [1,0,0]);
pause(0.01);                % give time to update screen

if handles.AttnChange == 1; % attenuator was changed
 attn           = handles.S.norm + get(handles.VolumeSlider, 'value');
 if get(handles.LeftEar,  'value');
  handles.Signal = [ handles.S.sil',               ...
                     handles.S.sil',               ...
                     handles.S.sil',               ...
                     handles.S.sil',               ...
                     handles.S.sil',               ...
                     handles.S.sil',               ...
                     dB2amp(handles.S.wave,attn)', ...
                     handles.S.sil' ];
 else
  handles.Signal = [ handles.S.sil',               ...
                     handles.S.sil',               ...
                     handles.S.sil',               ...
                     handles.S.sil',               ...
                     handles.S.sil',               ...
                     handles.S.sil',               ...
                     handles.S.sil',               ...
                     dB2amp(handles.S.wave,attn)'];
 end;
 handles.AttnChange = 0;   % attenuation is updated
 temp = 10*log10(mean(dB2amp(handles.S.wave,attn).^2));
 fprintf('Current level equals %2.0f dB\n', temp);
end;

trial = zeros(ceil(.025*handles.fs), 8);
maud_action('start');
maud_action('queue',[trial; handles.Signal; trial]);
maud_action('wait','output');

pause(0.01);                % give  time to update screen
set(handles.IsPlayPanel, 'Background', [0,1,0]);
