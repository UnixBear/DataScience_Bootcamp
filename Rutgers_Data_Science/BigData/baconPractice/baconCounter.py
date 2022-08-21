from mrjob.job import MRJob
class BaconCount(MRJob):
    def mapper(self, _, line):
        for word in line.split():
            yield "bacon", 1
    def reducer(self, key, values):
        yield key, sum(values)
        
if __name__ == "__main__":
    BaconCount.run()