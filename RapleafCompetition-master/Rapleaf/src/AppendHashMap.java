import java.util.HashMap;
import java.util.Map;
import java.util.Set;

public class AppendHashMap<T, U> extends HashMap<T, U> {

	public AppendHashMap() {
		super();
	}

	/**
	 * Appends k/v pairs in m to the current hashmap iterate through all keys
	 * and add values to existing keys if there is a match if there is no match
	 * create the key in the current hashmap
	 * 
	 * 
	 * @param m
	 */
	public void append(Map m) {
		// iterate through all keys and add to current key/values
		Set keys = m.entrySet();
		for (Object key : keys) {
			Set currentKeys = this.entrySet();
			if (currentKeys.contains(key)) {
				// get value and increment
				// hey how do we know the value has an increment method?
				// enforce this through an exception? Can we make this compile
				// time vs. runtime exception?
				Increment Value = (Increment) this.get(key);
				Value.increment();
			} else {
				// add key/value to current

			}

		}
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// test, ok this isnt a unit test....
		HashMap<Integer, AppendHashMap<String, Integer>> h1 = new HashMap<Integer, AppendHashMap<String, Integer>>();
		HashMap<Integer, AppendHashMap<String, Integer>> h2 = new HashMap<Integer, AppendHashMap<String, Integer>>();
		AppendHashMap<String, Integer> v1 = new AppendHashMap<String, Integer>();
		v1.put("word", new Integer(1));
		v1.put("the", new Integer(1));
		h1.put(new Integer(1), v1);
		System.out.println("before merge word:"
				+ h1.get(new Integer(1)).get("word"));

		AppendHashMap<String, Integer> v2 = new AppendHashMap<String, Integer>();
		v2.put("word", new Integer(4));
		h2.put(new Integer(1), v2);

		h1.putAll(h2);
		System.out.println("word:" + h1.get(new Integer(1)).get("word"));
	}

}
