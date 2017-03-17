function TestyTriangle

f=figure(1);
clf;
aH=axes('Xlim',[0,2],'Ylim',[0,1]);

% slingshot
line([0.2 0.2],[0 0.2],'color',[0.5451,0.2706,0.0745],'linewidth',5);
sling=line([0.2 0.2],[0.2 0.2],'color',[0.6275,0.3216,0.1765],'linewidth',2);
pos=text(1.56,0.96,'');

% bird
tri=line([0.2 0.2],[0.2 0.2],'color','red','linewidth',10,'Marker','>','MarkerFaceColor','r','ButtonDownFcn', @startDragFcn);

% pig
pig=line(1.0*[1 1],0.05*[1 1],'color','g','linewidth',21,'Marker','o','MarkerFaceColor','g');
set(pig,'Tag','Pig'); % allows us to locate the pig later

set(f,'WindowButtonUpFcn',@stopDragFcn);
set(f,'WindowButtonDownFcn',@startDragFcn); 

  function startDragFcn(varargin)
    set(f,'WindowButtonMotionFcn',@draggingFcn)
  end

  function draggingFcn(varargin)
    pt = get(aH,'CurrentPoint'); 
    dist = norm([pt(1),pt(3)]-[0.2,0.2]);
    if pt(1)<=0.2
      if dist<=0.15
        set(tri,'XData',pt(1)*[1 1],'YData',pt(3)*[1 1]);
        set(sling,'XData',[0.2 pt(1)],'YData',[0.2 pt(3)]);
        set(pos,'String',['x0 = ' num2str(pt(1)) ', y0 = ' num2str(pt(3))]);
      else
        newx=pt(1)+(dist-0.15)/dist*(0.2-pt(1));
        newy=pt(3)+(dist-0.15)/dist*(0.2-pt(3));
        set(tri,'XData',newx*[1 1],'YData',newy*[1 1]);
        set(sling,'XData',[0.2 newx],'YData',[0.2 newy]);
        set(pos,'String',['x0 = ' num2str(newx) ', y0 = ' num2str(newy)]);
      end
    end
  end

  function stopDragFcn(varargin)
    set(f,'WindowButtonMotionFcn','');
    sx=get(sling,'XData');
    sy=get(sling,'YData');
    dist = norm([sx(1)-sx(2),sy(1)-sy(2)]);
    if dist>0
      set(sling,'XData',[0.2 0.2],'YData',[0.2 0.2]);      
      set(tri,'color','w','MarkerFaceColor','w'); % triangle disappears
      px = get(pig,'XData'); % get pig's current location
      pig_x = px(1);
      
      x0=sx(2); y0=sy(2);
      speed=dist/0.15*4;

      % invoke the Shoot function for dynamic simulation
      hit = Shoot([x0;y0],atan((sy(2)-sy(1))/(sx(2)-sx(1))),speed,pig_x);
   
      position=get(pos,'Position');
      pos=text(1.56,position(2)-0.06,'');

      if hit
        % game over
        set(pos,'String','Hit!');
        set(f,'WindowButtonUpFcn','');
        set(f,'WindowButtonDownFcn',''); 
        set(f,'WindowButtonMotionFcn','');          
      else
        set(tri,'XData',[0.2 0.2],'YData',[0.2 0.2],'color','red','MarkerFaceColor','r'); % triangle reappears
      end
    end
  end
end
