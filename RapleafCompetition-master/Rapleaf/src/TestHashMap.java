import java.util.HashMap;

public class TestHashMap {

	public static void main(String[] args) {
		HashMap<Integer, HashMap<String, Integer>> h1 = new HashMap<Integer, HashMap<String, Integer>>();
		HashMap<Integer, HashMap<String, Integer>> h2 = new HashMap<Integer, HashMap<String, Integer>>();
		HashMap<String, Integer> v1 = new HashMap<String, Integer>();
		v1.put("word", new Integer(1));
		v1.put("the", new Integer(1));
		h1.put(new Integer(1), v1);
		System.out.println("before merge word:"
				+ h1.get(new Integer(1)).get("word"));

		HashMap<String, Integer> v2 = new HashMap<String, Integer>();
		v2.put("word", new Integer(4));
		h2.put(new Integer(1), v2);

		h1.putAll(h2);
		System.out.println("word:" + h1.get(new Integer(1)).get("word"));
		// conclusion: have to iterate through and increment manually.
		// extend the class and add a new method
	}
}
