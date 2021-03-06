namespace System.Collections.Generic {
        public class SyntaxSugar {
                public static void Shuffle<T>(this IList<T> list) {
                    var provider = new RNGCryptoServiceProvider();
                    int n = list.Count;
                    while (n > 1)
                    {
                        var box = new byte[4];
                        var rand = 0;
                        do
                        {
                            provider.GetBytes(box);
                            rand = BitConverter.ToInt32(box, 0);
                        } while (rand < 0);
                        var k = (rand % n);
                        n--;
                        var value = list[k];
                        list[k] = list[n];
                        list[n] = value;
                    }
                }
        }
}
