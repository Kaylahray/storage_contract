// THis is the contract Interface and allows updating and retrieval of name and age.

#[starknet::interface]
pub trait IStudent<TContractState> {
    fn update(ref self: TContractState, new_name: felt252, age_val: u8);
    fn get_name_and_age(self: @TContractState) -> (felt252, felt252);
}


#[starknet::contract]
mod Student {
    use core::starknet::storage::{StoragePointerReadAccess, StoragePointerWriteAccess};

    #[storage]
    struct Storage {
        name: felt252,
        age: u8,
    }

    #[abi(embed_v0)]
    impl StudentImpl of super::IStudent<ContractState> {
        fn update(ref self: ContractState, new_name: felt252, age_val: u8) {
            self.name.write(new_name);
            let current_age = self.age.read();
            self.age.write(current_age + age_val);
        }

        fn get_name_and_age(self: @ContractState) -> (felt252, felt252) {
            let name = self.name.read();
            let age = self.age.read();
            (name, age.into())
        }
    }
}
