# Add our dependencies.
import csv
import os
# Assign a variable to load a file from a path.
file_to_load = os.path.join("Resources", "election_results.csv")
# Assign a variable to save the file to a path.
file_to_save = os.path.join("Analysis", "election_analysis.txt")

candidate_votes = {}
total_votes = 0

winning_candidate = ''
greatest_vote = 0
winning_percentage = 0

# Open the election results and read the file.
with open(file_to_load) as election_data:
    file_reader = csv.reader(election_data)

    # Read and print the header row.
    headers = next(file_reader)
    print(headers)

    for row in file_reader:
        candidate_name = row[2]
        if candidate_name not in candidate_votes:
            candidate_votes[candidate_name] = 0
        else:
            candidate_votes[candidate_name] += 1
        if candidate_name not in candidate_options:
            candidate_options.append(candidate_name)
        total_votes += 1
    #for candidate in candidate_options:
    #    candidate_votes[candidate]=0

    with open(file_to_save, "w") as txt_file:
        election_results = (
            f"\nElection Results\n"
            f"-----------------------------------------\n"
            f"Total Votes: {total_votes:,}\n"
            f"-----------------------------------------\n"

        )
        print(election_results, end='')
        txt_file.write(election_results)
        for candidate in candidate_votes:
            votes = candidate_votes[candidate]
            vote_percentage = float(votes) / float(total_votes) * 100
            candidate_results = (f"{candidate}: {vote_percentage:.1f}% ({votes:,})\n")
            print(candidate_results)
            txt_file.write(candidate_results)
            if votePercentage > winning_percentage:
                winning_percentage = votePercentage
                winning_candidate = candidate
        
        #redundent print statement 
        #print("-----------------------------------------")
        #print(f"Winner: {winning_candidate}\nWinning Vote Count: {candidate_votes[winning_candidate]}\nWinning Percentage: {winning_percentage}% of the vote!")
        #print("-----------------------------------------")

        winner_summary = (
            f"-----------------------------------------\n"
            f"Winner: {winning_candidate}\n"
            f"Winning Count: {candidate_votes[winning_candidate]:,}\n"
            f"Winning Vote Percentage: {winning_percentage:.1f}%\n"
            f"-----------------------------------------\n"
        )
        print(write_to_file_summary)
        txt_file.write(winner_summary)
        
