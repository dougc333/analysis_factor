import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashMap;
import java.util.StringTokenizer;

//merge demographics with training
public class MakeData {
	private static final String DELIMITER = "\t";
	private static HashMap<Integer, Integer> uidsTraining = new HashMap<Integer, Integer>();
	private static HashMap<Integer, Integer> uidsEntry = new HashMap<Integer, Integer>();
	private static HashMap<Integer, String> uidsDemo = new HashMap<Integer, String>();

	// stats on numcategories
	private static HashMap<String, Integer> hmAge = new HashMap<String, Integer>();
	private static HashMap<String, Integer> hmMarry = new HashMap<String, Integer>();
	private static HashMap<String, Integer> hmLen = new HashMap<String, Integer>();
	private static HashMap<String, Integer> hmIncome = new HashMap<String, Integer>();
	private static HashMap<String, Integer> hmProp = new HashMap<String, Integer>();
	private static HashMap<String, Integer> hmStatus = new HashMap<String, Integer>();
	private static HashMap<String, Integer> hmLoc = new HashMap<String, Integer>();
	private static HashMap<String, Integer> hmValue = new HashMap<String, Integer>();
	private static HashMap<String, Integer> hmCity = new HashMap<String, Integer>();
	private static HashMap<String, Integer> hmState = new HashMap<String, Integer>();
	private static HashMap<String, Integer> hmCountry = new HashMap<String, Integer>();

	private static String cols[] = { "uid", "age", "gender", "children",
			"homemarketvalue", "homeownerstatus", "homepropertytype",
			"householdincome", "lengthofresidence", "maritalstatus" };

	private static final String HEADER = "uid" + "\t" + "beh" + "\t" + "pageV"
			+ "\t" + "uid" + "\t" + "age" + "\t" + "sex" + "\t" + "loc" + "\t"
			+ "child" + "\t" + "home$" + "\t" + "own" + "\t" + "prop" + "\t"
			+ "income" + "\t" + "residlen" + "\t" + "marital";

	private static final String HEADER_SHORT = "beh" + "\t" + "pageV" + "\t"
			+ "age" + "\t" + "sex" + "\t" + "child" + "\t" + "hval" + "\t"
			+ "own" + "\t" + "type" + "\t" + "income" + "\t" + "reslen" + "\t"
			+ "married";

	// change to true if you want to split headline.tsv files into 2 files, one
	// for training one for entry. Cant read entire headline.tsv into R
	private static final boolean SPLIT_HEADLINE_FILE = false;

	public MakeData() {
	}

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

	}

	// this is for R, does this make a difference to R if we put NA instead of
	// blanks in the data?
	private static void addNA(boolean formatWithNA, int numCols,
			boolean colExists, StringBuilder sb) {
		if (cols[numCols].equals("age") && !colExists) {
			sb.append("NAage" + "\t");
		} else if (cols[numCols].equals("gender") && !colExists) {
			sb.append("NAgender" + "\t");
		} else if (cols[numCols].equals("children") && !colExists) {
			sb.append("NAchild" + "\t");
		} else if (cols[numCols].equals("homemarketvalue") && !colExists) {
			sb.append("NAhomemarket" + "\t");
		} else if (cols[numCols].equals("homeownerstatus") && !colExists) {
			sb.append("NAhomestatus" + "\t");
		} else if (cols[numCols].equals("homepropertytype") && !colExists) {
			sb.append("NAhomeprop" + "\t");
		} else if (cols[numCols].equals("householdincome") && !colExists) {
			sb.append("NAincome" + "\t");
		} else if (cols[numCols].equals("lengthofresidence") && !colExists) {
			sb.append("NAlen" + "\t");
		} else if (cols[numCols].equals("maritalstatus") && !colExists) {
			sb.append("NAmarried" + "\t");
		}
	}

	private static void initDemographics(BufferedReader br,
			HashMap<Integer, String> hm) throws IOException {

		String fileLineDemo = null;
		System.out.println("header:" + br.readLine());

		while ((fileLineDemo = br.readLine()) != null) {
			System.out.println("br:" + fileLineDemo);
			StringTokenizer stDemo = new StringTokenizer(fileLineDemo, "\t",
					true);

			int numCols = 0;
			String uid = null;
			StringBuilder sb = new StringBuilder();
			boolean colExists = false;
			while (stDemo.hasMoreTokens()) {
				String token = stDemo.nextToken();
				System.out.println("stDemo token:" + token + " numCols:"
						+ numCols + "  ");

				if (token.equals("\t")) {
					System.out.println("delimiter," + numCols + " col:"
							+ cols[numCols]);
					addNA(true, numCols, colExists, sb);
					numCols++;
					colExists = false;
				} else {
					// System.out.println(cols[numCols] + "not tab:" + token);
					if (cols[numCols].equals("uid")) {
						uid = token;
						// numCols++; // why???
					} else if (cols[numCols].equals("age")) {
						if (hmAge.get(token) == null) {
							hmAge.put(token, new Integer(1));
						} else {
							hmAge.put(token, new Integer(hmAge.get(token) + 1));
						}
						// parse age average
						if (token.contains("-")) {
							StringTokenizer stAge = new StringTokenizer(token,
									"-");
							Integer lower = Integer.parseInt(stAge.nextToken());
							Integer upper = Integer.parseInt(stAge.nextToken());
							// System.out.println("lower:" + lower + " upper:"
							// + upper);
							Integer avg = (lower + upper) / 2;
							// System.out.println("avg age:" + avg);
							sb.append(avg + "\t");
						} else if (token.contains("+")) {
							StringTokenizer stAge = new StringTokenizer(token,
									"+");
							Integer lower = Integer.parseInt(stAge.nextToken());
							// System.out.println("lower age+:" + lower);
							sb.append(lower + "\t");
						} else {
							sb.append(token + "\t");
						}
						colExists = true;
					} else if (cols[numCols].equals("gender")) {
						sb.append(token + "\t");
						colExists = true;
					} else if (cols[numCols].equals("children")) {
						sb.append(token + "\t");
						colExists = true;
					} else if (cols[numCols].equals("homemarketvalue")) {
						if (hmValue.get(token) == null) {
							hmValue.put(token, new Integer(1));
						} else {
							hmValue.put(token, new Integer(
									hmValue.get(token) + 1));
						}
						if (token.startsWith("1mm")) {
							token = "1000";
						}
						if (token.contains("-")) {
							StringTokenizer st = new StringTokenizer(token, "-");
							String lower = st.nextToken();
							String upper = st.nextToken();
							if (upper.startsWith("1mm")) {
								upper = "1000k";
							}
							Integer lowerVal = Integer.parseInt(lower.replace(
									"k", " ").trim());
							Integer upperVal = Integer.parseInt(upper.replace(
									"k", " ").trim());
							Integer avgVal = (lowerVal + upperVal) / 2;
							sb.append(avgVal + "\t");
						} else {
							sb.append(token + "\t");
						}
						colExists = true;
					} else if (cols[numCols].equals("homeownerstatus")) {
						if (hmStatus.get(token) == null) {
							hmStatus.put(token, new Integer(1));
						} else {
							hmStatus.put(token, new Integer(
									hmStatus.get(token) + 1));
						}
						sb.append(token + "\t");
						colExists = true;
					} else if (cols[numCols].equals("homepropertytype")) {
						if (hmProp.get(token) == null) {
							hmProp.put(token, new Integer(1));
						} else {
							hmProp.put(token,
									new Integer(hmProp.get(token) + 1));
						}
						sb.append(token + "\t");
						colExists = true;
					} else if (cols[numCols].equals("householdincome")) {
						if (hmIncome.get(token) == null) {
							hmIncome.put(token, new Integer(1));
						} else {
							hmIncome.put(token, new Integer(
									hmIncome.get(token) + 1));
						}
						sb.append(token + "\t");
						colExists = true;
					} else if (cols[numCols].equals("lengthofresidence")) {
						if (hmLen.get(token) == null) {
							hmLen.put(token, new Integer(1));
						} else {
							hmLen.put(token, new Integer(hmLen.get(token) + 1));
						}
						sb.append(token + "\t");
						colExists = true;
					} else if (cols[numCols].equals("maritalstatus")) {
						if (hmMarry.get(token) == null) {
							hmMarry.put(token, new Integer(1));
						} else {
							hmMarry.put(token, new Integer(
									hmMarry.get(token) + 1));
						}
						sb.append(token + "\t");
						colExists = true;
					}

				}

			}
			hm.put(Integer.parseInt(uid), sb.toString());
			System.out.println("sb:" + sb.toString());
			// System.exit(0);
		}
		br.close();
	}

	public static void main(String[] args) {
		try {
			BufferedReader training = new BufferedReader(new FileReader(
					"/Users/dc/Desktop/training.csv"));
			BufferedReader entry = new BufferedReader(new FileReader(
					"/Users/dc/Desktop/example_entry.csv"));

			BufferedReader demographics = new BufferedReader(new FileReader(
					"/Users/dc/Desktop/demographics.tsv"));

			// headlien files only not joined
			BufferedWriter bwHeadTrain = new BufferedWriter(new FileWriter(
					"/Users/dc/Desktop/HeadTrain.txt"));
			BufferedWriter bwHeadEntry = new BufferedWriter(new FileWriter(
					"/Users/dc/Desktop/HeadEntry.txt"));

			// joined files with demographics, headlines and uid
			BufferedWriter bwHeadlineTraining = new BufferedWriter(
					new FileWriter("/Users/dc/Desktop/HeadlineTraining.txt"));
			BufferedWriter bwHeadlineEntry = new BufferedWriter(new FileWriter(
					"/Users/dc/Desktop/HeadlineEntry.txt"));

			BufferedWriter bwVisits = new BufferedWriter(new FileWriter(
					"/Users/dc/Desktop/uidnumvisit.txt"));

			BufferedWriter bwHeadlineStats = new BufferedWriter(new FileWriter(
					"/Users/dc/Desktop/headlinestats.txt"));
			bwHeadlineTraining.write(HEADER_SHORT);
			bwHeadlineTraining.newLine();
			bwHeadlineEntry.write(HEADER_SHORT);
			bwHeadlineEntry.newLine();
			initHashMap(training, uidsTraining);
			initHashMap(entry, uidsEntry);
			initDemographics(demographics, uidsDemo);
			training.close();
			entry.close();

			// parse the headline data into 2 files, one for training one for
			// entry
			BufferedReader brHeadlines = new BufferedReader(new FileReader(
					"/Users/dc/Desktop/headlines.tsv"));
			String headline = null;

			HashMap<Integer, Integer> headlineUIDS = new HashMap<Integer, Integer>();
			brHeadlines.readLine(); // get rid of header, uid, url, headline,
									// repetitions
			Integer currentUID = 0;
			Integer uidHeadline = 0;
			Integer numRepetitions = 0;
			Integer numURLS = 0;

			while ((headline = brHeadlines.readLine()) != null) {
				// System.out.println("headline:" + headline);

				String splitMe[] = headline.split("\t");
				uidHeadline = Integer.parseInt(splitMe[0]);
				if (uidsTraining.get(Integer.parseInt(splitMe[0])) != null
						&& SPLIT_HEADLINE_FILE) {
					bwHeadTrain.write(headline);
					bwHeadTrain.newLine();
				} else if ((uidsEntry.get(Integer.parseInt(splitMe[0])) != null)
						&& SPLIT_HEADLINE_FILE) {
					bwHeadEntry.write(headline);
					bwHeadEntry.newLine();
				}

				// System.out.println("splitMe length:" + splitMe.length);
				if (splitMe.length != 4) {
					System.out.println("not 4");
					System.exit(0);
				}

				if (splitMe[1].trim().length() == 0
						&& splitMe[2].trim().length() == 0) {
					if (Integer.parseInt(splitMe[3]) > 1000) {
						System.out.println("summary line:" + headline);
					}
					bwVisits.write(headline);
					bwVisits.newLine();
					// write data into files
					if (uidsEntry.get(uidHeadline) != null) {
						bwHeadlineEntry
								.write(splitMe[0] + "\t"
										+ uidsEntry.get(uidHeadline) + "\t"
										+ splitMe[3] + "\t"
										+ uidsDemo.get(uidHeadline));
						bwHeadlineEntry.newLine();
					} else if (uidsTraining.get(uidHeadline) != null) {
						// remove split[0]+"\t"
						bwHeadlineTraining.write(uidsTraining.get(uidHeadline)
								+ "\t" + splitMe[3] + "\t"
								+ uidsDemo.get(uidHeadline));
						bwHeadlineTraining.newLine();
					}
				}
				if (splitMe[0].trim().length() > 0) {
					// test and write headline fileLine into file
					uidHeadline = Integer.parseInt(splitMe[0]);

					if (uidHeadline != currentUID) {
						// print out summary info, zero again
						// System.out.println("uid:" + currentUID + " numURLS:"
						// + numURLS + " repetitions:" + numRepetitions);
						bwHeadlineStats.write("uidHeadline" + uidHeadline
								+ " currentUID:" + currentUID + " numURLS:"
								+ numURLS + " repetitions:" + numRepetitions);
						bwHeadlineStats.newLine();
						currentUID = uidHeadline;
						numRepetitions = 0;
						numURLS = 0;
					}
				}
				if (splitMe[1].trim().length() > 0) {
					String url = splitMe[1];
					numURLS++;
				}
				if (splitMe[2].trim().length() > 0) {
					String title = splitMe[2];
				}
				if (splitMe[3].trim().length() > 0) {
					Integer repetitions = Integer.parseInt(splitMe[3]);
					numRepetitions += repetitions;
				}
			}

			System.out.println("num UIDS in headlines:" + headlineUIDS.size());
			bwHeadlineStats.close();
			bwHeadlineTraining.close();
			bwHeadlineEntry.close();
			bwVisits.close();
			bwHeadTrain.close();
			bwHeadEntry.close();

			System.out.println("num data categories");

			System.out.println("hmAge num:" + hmAge.size());
			System.out.println("hmMarry num:" + hmMarry.size());
			System.out.println("hmLen num:" + hmLen.size());
			System.out.println("hmIncome num:" + hmIncome.size());
			System.out.println("hmProp num:" + hmProp.size());
			System.out.println("hmStatus num:" + hmStatus.size());
			System.out.println("hmLoc num:" + hmLoc.size());
			System.out.println("hmCity num:" + hmCity.size());
			System.out.println("hmState num:" + hmState.size());
			System.out.println("hmCountry num:" + hmCountry.size());
			System.out.println("hmValue num:" + hmValue.size());
			// iterate locations
			// Set<String> keys = hmLoc.keySet();
			// for (String k : keys) {
			// System.out.println("loc:" + k + " ," + hmLoc.get(k));
			// }

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}