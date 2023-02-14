import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;
import java.util.StringTokenizer;

/**
 * Reformats the rapleaf data by joining it and cleaning data fields
 * 
 * @author dc
 * 
 */
public class RapleafCleanData {
	private static BufferedReader training;
	private static BufferedReader entry;

	private static BufferedWriter bwHeadTrain;
	private static BufferedWriter bwHeadlineTraining;
	private static BufferedWriter bwHeadlineEntry;
	private static BufferedWriter bwVisits;
	private static BufferedWriter bwHeadlineStats;

	private static final String DELIMITER = "\t";
	private static HashMap<Integer, Integer> uidsTraining = new HashMap<Integer, Integer>();
	private static HashMap<Integer, Integer> uidsEntry = new HashMap<Integer, Integer>();
	private static HashMap<Integer, String> uidsDemo = new HashMap<Integer, String>();

	private static final String HEADER = "uid" + "\t" + "pageV" + "\t" + "uid"
			+ "\t" + "age" + "\t" + "sex" + "\t" + "loc" + "\t" + "child"
			+ "\t" + "home$" + "\t" + "own" + "\t" + "prop" + "\t" + "income"
			+ "\t" + "residlen" + "\t" + "marital";

	// uid, pageVisits
	private static HashMap<Integer, Integer> pageVisits = new HashMap<Integer, Integer>();

	private static void init() throws IOException {
		training = new BufferedReader(new FileReader(
				"/Users/dc/Desktop/training.csv"));
		entry = new BufferedReader(new FileReader(
				"/Users/dc/Desktop/example_entry.csv"));

		// headlien files only not joined
		// BufferedWriter bwHeadTrain = new BufferedWriter(new FileWriter(
		// "/Users/dc/Desktop/HeadTrain.txt"));
		// BufferedWriter bwHeadEntry = new BufferedWriter(new FileWriter(
		// "/Users/dc/Desktop/HeadEntry.txt"));

		// joined files with demographics, headlines and uid
		bwHeadlineTraining = new BufferedWriter(new FileWriter(
				"/Users/dc/Desktop/HeadlineTraining.txt"));
		bwHeadlineEntry = new BufferedWriter(new FileWriter(
				"/Users/dc/Desktop/HeadlineEntry.txt"));
		bwHeadlineTraining.write(HEADER);
		bwHeadlineTraining.newLine();
		bwHeadlineEntry.write(HEADER);
		bwHeadlineEntry.newLine();

	}

	/**
	 * initHashMap Input: training or entry file with uid in first column and
	 * behavior in second column Output: hashmap<uid,behvior> used to join
	 * headlines.tsv file with uid/urls
	 * 
	 * @param csvFile
	 * @param hm
	 * @throws IOException
	 */
	private static void initHashMap(BufferedReader csvFile,
			HashMap<Integer, Integer> hm) throws IOException {
		String fileLine = null;
		int numLines = 0;
		csvFile.readLine();
		while ((fileLine = csvFile.readLine()) != null) {
			// System.out.println("fileLine:" + fileLine);
			StringTokenizer st = new StringTokenizer(fileLine, ",");
			String uid = st.nextToken();
			String behavior = st.nextToken();
			if (!(behavior.equals("0") || behavior.equals("1"))) {
				System.out.println("error in behavior variable not 0 or 1");
				System.exit(0);
			}
			if (hm.get(Integer.parseInt(uid)) == null) {
				hm.put(Integer.parseInt(uid), Integer.parseInt(behavior));
			}
			numLines++;
		}
		System.out.println("num distinct uids in csv file:" + hm.size());
		System.out.println("numLines training.csv file:" + numLines);
		System.out
				.println("if num distinct uids == numlines then we have no dups");
		csvFile.close();
	}

	private static void initDemographics() throws IOException {
		BufferedReader demographics = new BufferedReader(new FileReader(
				"/Users/dc/Desktop/demographics.tsv"));
		String fileLineDemo = null;
		// System.out.println("header:" + br.readLine());

		int numDemoInTraining = 0;
		int numDemoInEntry = 0;
		demographics.readLine(); // get rid of header
		StringBuilder sb = new StringBuilder();
		while ((fileLineDemo = demographics.readLine()) != null) {
			StringTokenizer st = new StringTokenizer(fileLineDemo, "\t", true);
			int numTokens = st.countTokens();
			// System.out.println("numtokens:" + st.countTokens());

			// calculate joined tokens
			String uid = st.nextToken();

			if (uidsTraining.get(Integer.parseInt(uid)) != null) {
				numDemoInTraining++;
				if (pageVisits.get(Integer.parseInt(uid)) == null) {
					pageVisits.put(Integer.parseInt(uid), new Integer(0));
				}
				bwHeadlineTraining.write(uid + "\t"
						+ uidsTraining.get(Integer.parseInt(uid)) + "\t"
						+ pageVisits.get(Integer.parseInt(uid)) + "\t"
						+ fileLineDemo);
				bwHeadlineTraining.newLine();
			}
			if (uidsEntry.get(Integer.parseInt(uid)) != null) {
				numDemoInEntry++;
				if (pageVisits.get(Integer.parseInt(uid)) == null) {
					pageVisits.put(Integer.parseInt(uid), new Integer(0));
				}
				bwHeadlineEntry.write(uid + "\t"
						+ uidsEntry.get(Integer.parseInt(uid))
						+ pageVisits.get(Integer.parseInt(uid)) + "\t"
						+ fileLineDemo);
				bwHeadlineEntry.newLine();
			}

		}
		System.out.println("numDemoLinesInTraining:" + numDemoInTraining
				+ " numDemoLinesInEntry:" + numDemoInEntry);
		demographics.close();
		bwHeadlineTraining.close();
		bwHeadlineEntry.close();
	}

	// I only need the summary lines of pages visited from headlines.tsv
	// sum the repetitions per uid can we get an average of user visits?
	public static void initHeadlines() throws IOException {
		BufferedReader brHeadlines = new BufferedReader(new FileReader(
				"/Users/dc/Desktop/headlines.tsv"));
		String readLine = null;
		int numHeadlineInTraining = 0;
		int numHeadlineInEntry = 0;
		brHeadlines.readLine(); // get rid of header
		while ((readLine = brHeadlines.readLine()) != null) {

			String[] tokens = readLine.split("\t");
			if (tokens.length != 4) {
				System.exit(0);
			}
			// summary line where 2nd and 3rd columns have no data
			if (tokens[1].length() == 0 && tokens[2].length() == 0) {

				if (uidsTraining.get(Integer.parseInt(tokens[0])) != null) {
					numHeadlineInTraining++;
				}
				if (uidsEntry.get(Integer.parseInt(tokens[0])) != null) {
					numHeadlineInEntry++;
				}
				if (((uidsTraining.get(Integer.parseInt(tokens[0])) != null) || (uidsEntry
						.get(Integer.parseInt(tokens[0])) != null))) {
					// have to test if string is null else we get N/A in the
					// final R file which doesnt work.
					// needs to be 0 if fileline is null
					if (pageVisits.get(Integer.parseInt(tokens[0])) == null) {
						if (tokens[3] == null) {
							pageVisits.put(Integer.parseInt(tokens[0]),
									new Integer(0));
						} else {
							pageVisits.put(Integer.parseInt(tokens[0]),
									Integer.parseInt(tokens[3]));

						}

					}
				}
			}

		}
		System.out.println("num headlines in training:" + numHeadlineInTraining
				+ "num headlines in entry:" + numHeadlineInEntry);
		System.out.println("size pageVisits hashmap:" + pageVisits.size());
		brHeadlines.close();
	}

	public static void main(String[] args) {
		try {
			init();
			initHashMap(training, uidsTraining);
			initHashMap(entry, uidsEntry);
			initHeadlines();
			initDemographics();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
