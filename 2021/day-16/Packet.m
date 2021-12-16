classdef Packet < handle

  properties
    version
    type
    value
    subs
  end

  methods

    function obj = Packet( version, type, value, subs )
      obj.version = version;
      obj.type = type;
      obj.value = value;
      obj.subs = subs;
    end

    function res = sumVersion( self )

      res = self.version;
      for p = self.subs
        res = res + p.sumVersion();
      end

    end

    function res = compute( self )

      V = zeros( size( self.subs ) );
      for i = 1:length( self.subs )
        V(i) = self.subs(i).compute();
      end

      switch self.type

        case 0
          res = sum( V );
        case 1
          res = prod( V );
        case 2
          res = min( V );
        case 3
          res = max( V );
        case 4
          res = self.value;
        case 5
          res = V(1) > V(2);
        case 6
          res = V(1) < V(2);
        case 7
          res = V(1) == V(2);

      end

    end

  end

  methods( Static )

    function packet = read( hex )

      HEX = [ '0':'9' 'A':'F' ];
      BITS = [ ...
        0 0 0 0 0 0 0 0 1 1 1 1 1 1 1 1
        0 0 0 0 1 1 1 1 0 0 0 0 1 1 1 1
        0 0 1 1 0 0 1 1 0 0 1 1 0 0 1 1
        0 1 0 1 0 1 0 1 0 1 0 1 0 1 0 1 ]';

      [ ~, loc ] = ismember( hex, HEX );
      bits = reshape( BITS( loc, : )', 1, [] );

      [ packet, ~ ] = Packet.readbits( bits, 1 );

    end

    function [ packet, ptr ] = readbits( bits, ptr )

      [ version, ptr ] = Packet.hexval( bits, ptr, 3 );
      [ type, ptr ] = Packet.hexval( bits, ptr, 3 );

      value = [];
      subs = Packet.empty;

      if type == 4

        n = 1;
        while n == 1
          [ n, ptr ] = Packet.hexval( bits, ptr, 1 );
          [ value(end+1), ptr ] = Packet.hexval( bits, ptr, 4 ); %#ok<AGROW>
        end

        value = value * 16.^( length(value)-1:-1:0 )';

      else

        [ lt, ptr ] = Packet.hexval( bits, ptr, 1 );
        if lt == 0

          [ len, ptr ] = Packet.hexval( bits, ptr, 15 );
          end_ptr = ptr + len;
          while ptr ~= end_ptr
            [ subs(end+1), ptr ] = Packet.readbits( bits, ptr ); %#ok<AGROW>
          end

        else

          [ len, ptr ] = Packet.hexval( bits, ptr, 11 );
          for i = 1:len
            [ subs(end+1), ptr ] = Packet.readbits( bits, ptr ); %#ok<AGROW>
          end

        end

      end

      packet = Packet( version, type, value, subs );

    end

    function [ val, ptr ] = hexval( bits, ptr, len )
      val = bits(ptr:ptr+len-1) * 2.^( len-1:-1:0 )';
      ptr = ptr + len;
    end

  end

end