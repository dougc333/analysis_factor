import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;

public class ARFFMake {

	public static void main(String[] args) {
		try {
			BufferedReader br = new BufferedReader(new FileReader(
					"/Users/dc/Desktop/training.txt"));
			br.readLine(); // get rid of header
			BufferedWriter bw = new BufferedWriter(new FileWriter(
					"/Users/dc/Desktop/arfftraining.arff"));

			String rel = "@RELATION training";
			bw.write(rel);
			bw.newLine();
			bw.newLine();

			String arfAttribues[] = { "@ATTRIBUTE uid NUMERIC",
					"@ATTRIBUTE beh NUMERIC", "@ATTRIBUTE sum NUMERIC",
					"@ATTRIBUTE rep NUMERIC", "@ATTRIBUTE bag NUMERIC",
					"@ATTRIBUTE bigram NUMERIC", "@ATTRIBUTE uid.1 NUMERIC",
					"@ATTRIBUTE age NUMERIC", "@ATTRIBUTE sex NUMERIC",
					"@ATTRIBUTE loc NUMERIC", "@ATTRIBUTE child NUMERIC",
					"@ATTRIBUTE homeval NUMERIC", "@ATTRIBUTE owner NUMERIC",
					"@ATTRIBUTE prop_type NUMERIC",
					"@ATTRIBUTE houseincome NUMERIC",
					"@ATTRIBUTE lenresid NUMERIC", "@ATTRIBUTE marital NUMERIC" };

			for (String s : arfAttribues) {
				bw.write(s);
				bw.newLine();
			}
			bw.newLine();

			// data lines,
			String fileLine = null;
			bw.write("@DATA");
			bw.newLine();
			while ((fileLine = br.readLine()) != null) {
				bw.write(fileLine.replace("\t", ","));
				bw.newLine();
			}
			bw.close();
			br.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
