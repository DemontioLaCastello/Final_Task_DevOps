import unittest
from proper_solution import two_sum as proper_two_sum
from fallback_solution import two_sum as fallback_two_sum

class TestTwoSum(unittest.TestCase):

    def test_proper_solution(self):
        # Test case 1: Basic example
        nums1 = [2, 11, 7, 15]
        target1 = 9
        self.assertEqual(proper_two_sum(nums1, target1), [0, 2])

        # Test case 3: Multiple solutions
        nums2 = [3, 3]
        target2 = 6
        self.assertEqual(proper_two_sum(nums2, target2), [0, 1])

    def test_fallback_solution(self):
        # Test case 1: Basic example
        nums1 = [2, 11, 7, 15]
        target1 = 9
        self.assertEqual(fallback_two_sum(nums1, target1), [0, 2])

        # Test case 3: Multiple solutions
        nums2 = [3, 3]
        target2 = 6
        self.assertEqual(fallback_two_sum(nums2, target2), [0, 1])

if __name__ == '__main__':
    unittest.main()
