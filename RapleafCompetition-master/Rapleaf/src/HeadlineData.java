import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.StringTokenizer;
import java.util.Vector;

public class HeadlineData {
	private static BufferedReader training;
	private static BufferedReader entry;

	private static HashMap<Integer, Integer> uidsTraining = new HashMap<Integer, Integer>();
	private static HashMap<Integer, Integer> uidsEntry = new HashMap<Integer, Integer>();
	private static HashMap<Integer, Integer> uidsSummary = new HashMap<Integer, Integer>();
	private static HashMap<Integer, Vector<String>> bagOfWords = new HashMap<Integer, Vector<String>>();

	private static void initHashMap(BufferedReader csvFile,
			HashMap<Integer, Integer> hm) throws IOException {
		String fileLine = null;
		int numLines = 0;
		csvFile.readLine();
		while ((fileLine = csvFile.readLine()) != null) {
			// System.out.println("fileLine:" + fileLine);
			StringTokenizer st = new StringTokenizer(fileLine, ",");
			String uid = st.nextToken();
			// just store uids.
			if (hm.get(Integer.parseInt(uid)) == null) {
				hm.put(Integer.parseInt(uid), new Integer(0));
			}
			numLines++;
		}
		System.out.println("num distinct uids in csv file:" + hm.size());
		System.out.println("numLines training.csv file:" + numLines);
		System.out
				.println("if num distinct uids == numlines then we have no dups");
		csvFile.close();
	}

	// reformat the headline.tsv file
	// hashmap<uid, <numReps, num>>; store num reps per count. How about
	// percentage?
	// this gives total numReps/uid with an iterator
	public static void main(String[] args) {
		try {
			// get uid list of entry and training tables first.
			training = new BufferedReader(new FileReader(
					"/Users/dc/Desktop/training.csv"));
			entry = new BufferedReader(new FileReader(
					"/Users/dc/Desktop/example_entry.csv"));

			initHashMap(training, uidsTraining);
			initHashMap(entry, uidsEntry);
			HashMap<String, HashMap<Integer, Integer>> hm;
			BufferedReader brHeadlines = new BufferedReader(new FileReader(
					"/Users/dc/Desktop/headlines.tsv"));
			String readLine = null;
			brHeadlines.readLine(); // header
			int numUIDS = 0;
			while ((readLine = brHeadlines.readLine()) != null) {

				String fields[] = readLine.split("\t");
				if (fields[1].trim().length() == 0
						&& fields[2].trim().length() == 0) {
					System.out.println("home page line:" + readLine);
					if (uidsSummary.get(Integer.parseInt(fields[0])) == null) {
						uidsSummary.put(Integer.parseInt(fields[0]),
								Integer.parseInt(fields[3]));
					} else {
						// error shouldnt see this before
						System.out
								.println("we have a duplicate summary line. You shouldnt see this");
						System.exit(0);
					}
				} else {
					// System.out.println("rep line");
					// accumulate rep stats per uid
					// there must be a login uid or webpage common to the ones
					// which are paying customers
					String uid = fields[0];
					String reps = fields[3]; // how do we use the url data?
					String headlineTitles = fields[2]; // bag of words
					// bag of words
					if (bagOfWords.get(Integer.parseInt(fields[0])) == null) {
						Vector<String> v = new Vector<String>();
						if (fields[2].trim().length() > 1) {
							StringTokenizer st = new StringTokenizer(fields[2]);
							while (st.hasMoreTokens()) {
								String token = st.nextToken();

							}
						}
					} else {
						addToBag(fields[0], fields[2]);
					}
				}

			}
			System.out.println("numUIDS:" + numUIDS);
			System.out.println("numSummaryLines:" + uidsSummary.size());

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
