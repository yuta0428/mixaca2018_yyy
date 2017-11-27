  defprotocol Cipher do
    def encrypt(string, shift)

    def rot13(string)
  end

  defimpl Cipher, for: string do
    def encrypt(string, shift) do
      
    end

    def rot13(string) do
      
    end
  end
  