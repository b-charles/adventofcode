classdef Obj < handle

  properties
    name
    center
    satelites = []

    orbits = NaN
  end

  methods

    function o = Obj( name )
      o.name = name;
    end

    function addSat( this, sat )
      this.satelites = [ this.satelites sat ];
      sat.center = this;
    end

    function n = getOrbits( this )

      if length( this ) > 1
        n = zeros( size( this ) );
        for i = 1:length( this(:) )
          n(i) = this(i).getOrbits();
        end
        return;
      end

      if isnan( this.orbits )
        if isempty( this.center )
          this.orbits = 0;
        else
          this.orbits = this.center.getOrbits() + 1;
        end
      end

      n = this.orbits;

    end

    function P = allParents( this )

      if isempty( this.center )
        P = [];
      else
        P = [ this.center.allParents() this.center ];
      end

    end

  end

  methods( Static )

    function o = getByName( name )
      persistent all;
      if isempty( all )
        all = struct();
      end

      name = sprintf( 'OBJ_%s', name );

      if isfield( all, name )
        o = all.(name);
      else
        o = Obj( name );
        all.(name) = o;
      end

    end

  end

end
