public class CountUp {
    public static void countToTen() {
        Integer count = 1; // Initialize the count variable
        do {
            System.debug(count); // Log the current count to the debug log
            count++; // Increment the count by 1
        } while (count <= 10); // Continue loop until count is greater than 10
    }
}