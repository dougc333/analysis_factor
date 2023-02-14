import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;

public class ReformatTabToCommas {

	private static void format(BufferedReader br, BufferedWriter bw)
			throws Exception {
		String fileLine = null;

		while ((fileLine = br.readLine()) != null) {
			bw.write(fileLine.replaceAll("\t", ";"));
			bw.newLine();
		}
		br.close();
		bw.close();

	}

	public static void main(String[] args) {
		try {
			BufferedReader br = new BufferedReader(new FileReader(
					"/Users/dc/Desktop/HeadlineTraining.txt"));
			BufferedWriter bw = new BufferedWriter(new FileWriter(
					"/Users/dc/Desktop/HeadlineTrainingFormatted.txt"));

			format(br, bw);
			BufferedReader br1 = new BufferedReader(new FileReader(
					"/Users/dc/Desktop/HeadlineEntry.txt"));
			BufferedWriter bw1 = new BufferedWriter(new FileWriter(
					"/Users/dc/Desktop/HeadlineEntryFormatted.txt"));
			format(br1, bw1);

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
