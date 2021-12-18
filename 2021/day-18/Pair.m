classdef Pair < handle

  properties

    parent = Pair.empty;
    pos = 0;

    value = [];
    isValue = false;

    left = Pair.empty;
    right = Pair.empty;

  end

  methods

    function obj = Pair( varargin )

      if length( varargin ) == 1

        obj.value = varargin{1};
        obj.isValue = true;

      else

        obj.left = varargin{1};
        obj.left.parent = obj;
        obj.left.pos = -1;

        obj.right = varargin{2};
        obj.right.parent = obj;
        obj.right.pos = 1;

      end

    end

    function p = copy( self )
      if self.isValue
        p = Pair( self.value );
      else
        p = Pair( self.left.copy(), self.right.copy() );
      end
    end

    function str = toStr( self )
      if self.isValue
        str = num2str( self.value );
      else
        str = [ '[' self.left.toStr() ',' self.right.toStr() ']' ];
      end
    end

    function disp( self )
      fprintf( [ self.toStr() '\n\n' ] );
    end

    function m = mag( self )

      if self.isValue
        m = self.value;
      else
        m = 3*self.left.mag() + 2*self.right.mag();
      end

    end

  end

  %% SUM

  methods

    function r = plus( self, p )
      r = Pair( self.copy(), p.copy() );
      while( r.explode(0) || r.split() )
      end
    end

    function S = sum( P )
      S = P(1);
      for i = 2:length(P)
        S = S + P(i);
      end
    end

  end

  %% EXPLODE

  methods

    function hadExploded = explode( self, depth )
      if nargin == 1
        depth = 0;
      end

      if ~self.left.isValue || ~self.right.isValue
        hadExploded = ( ~self.left.isValue && self.left.explode( depth + 1 ) ) ...
          || ( ~self.right.isValue && self.right.explode( depth + 1 ) );
        return
      end

      if depth < 4
        hadExploded = false;
        return
      end

      hadExploded = true;
      self.explodeLeft();
      self.explodeRight();

      self.value = 0;
      self.isValue = true;
      self.left = Pair.empty;
      self.right = Pair.empty;

    end

    function explodeLeft( self )
      c = self;
      while c.pos == -1
        c = c.parent;
        if c.pos == 0
          return
        end
      end
      c = c.parent.left;
      while ~c.isValue
        c = c.right;
      end
      c.value = c.value + self.left.value;
    end

    function explodeRight( self )
      c = self;
      while c.pos == 1
        c = c.parent;
        if c.pos == 0
          return
        end
      end
      c = c.parent.right;
      while ~c.isValue
        c = c.left;
      end
      c.value = c.value + self.right.value;
    end

  end

  %% SPLIT

  methods

    function hadSplit = split( self )

      if ~self.isValue
        hadSplit = self.left.split() || self.right.split();
        return
      end

      if self.value < 10
        hadSplit = false;
        return
      end

      hadSplit = true;

      self.left = Pair( floor( self.value / 2 ) );
      self.left.parent = self;
      self.left.pos = -1;

      self.right = Pair( ceil( self.value / 2 ) );
      self.right.parent = self;
      self.right.pos = 1;

      self.value = [];
      self.isValue = false;

    end

  end

end