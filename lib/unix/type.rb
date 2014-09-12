# Contains helper methods for C-struct types.
module UNIX
  module Type
    extend self

    # Returns the size of a C-struct type.
    # A replacement for C's sizeof() function.
    def sizeof(type)
      size_ptr = Pointer.new(:ulong_long)
      align_ptr = Pointer.new(:ulong_long)
      NSGetSizeAndAlignment(type, size_ptr, align_ptr)
      size_ptr[0]
    end

  end
end
